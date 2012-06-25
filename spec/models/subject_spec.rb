# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Subject do
  before(:each) do
    @city = Factory(:city)
    @typesubject = Factory(:typesubject)
    @district = Factory(:district)
    @resident = Factory(:resident)
    @customer = Factory(:customer)
    @subject = Factory(:subject, :typesubject => @typesubject, :city => @city, 
        :customer => @customer, :district => @district, :resident => @resident)
    
    # typesubject without floor
    @withourfloor = Factory(:withourfloor)
    
    # typesubject without room
    @withoutroom = Factory(:withoutroom)
    
    # price_currency
    @pricecur = {
      "тенге" => "тенге",
      "доллар" => "доллар",
      "евро" => "евро",
      "рубль" => "рубль"
    }
    
    # properties
    @properties = Factory(:property, :subject => @subject)
    
    # valid attributes
    @attr = {
      :typesubject_id => @typesubject.id,
      :city_id => @city.id,
      :customer_id => @customer.id,
      :price => 100003,
      :area => 80,
      :address => "Баймагамбетова 15, 23",
      :district_id => @district.id,
      :resident_id => @resident.id,
      :floor => 1,
      :floorall => 9,
      :room => 5,
      :active => true,
      :price_currency => @pricecur["доллар"],
      :note => "Адекватная квартира"
    }
  end
  
  it "should verify_customer_real(potentials = false)" do
    subject = @subject
    subject.verify_customer_real
    subject.customer.potentials.should == false
  end
  
  it "should verify_customer_real(potentials = true)" do
    subject = @subject
    @customer[:potentials] = true
    subject.customer = @customer
    subject.customer.potentials.should == true
  end
  
  it "should active == true" do
    subject = Subject.create(@attr.merge(:active => nil))
    subject.active == true
  end
  
  describe "validations" do
    it "should create new instance with valid attributes" do
      subject = Subject.create!(@attr)
    end
    
    it "should require the typesubject_id" do
      subject = Subject.new(@attr.merge(:typesubject_id => nil))
      subject.should_not be_valid
    end
    
    it "should require the city_id" do
      subject = Subject.new(@attr.merge(:city_id => nil))
      subject.should_not be_valid
    end
    
    it "should require the price" do
      subject = Subject.new(@attr.merge(:price => nil))
      subject.should_not be_valid
    end
    
    it "should price the numericality" do
      @attr[:price] = "dededeede"
      subject = Subject.new(@attr)
      subject.should_not be_valid
    end
    
    it "should require the customer_id" do
      @attr[:customer_id] = nil
      subject = Subject.new(@attr)
      subject.should_not be_valid
    end
    
    it "should require the district_id" do
      @attr[:district_id] = nil
      subject = Subject.new(@attr)
      subject.should_not be_valid
    end
    
    it "should not note more than 800 characters" do
      @attr[:note] = @attr[:note]*800
      subject = Subject.new(@attr)
      subject.should_not be_valid
    end
    
    # floor
    describe "validation floor" do
      it "should require floor if typesubject.floor == true" do
        subject = Subject.new(@attr)
        if subject.typesubject.floor == true
          subject.floor = nil
          subject.should_not be_valid
        end
      end
      
      it "should be valid if typesubject.floor == false" do
        subject = Subject.new(@attr.merge(:typesubject_id => @withourfloor.id))
        subject.floor = nil
        subject.should be_valid
      end
      
      # floor all
      it "should require floorall if typesubject.floor == true" do
        subject = Subject.new(@attr)
        if subject.typesubject.floor == true
          subject.floorall = nil
          subject.should_not be_valid
        end
      end
      
      it "should be valid if typesubject.floor == false" do
        subject = Subject.new(@attr.merge(:typesubject_id => @withourfloor.id))
        subject.floorall = nil
        subject.should be_valid
      end
    end
    
    # room
    describe "validation room" do
      it "should require room if typesubject.room == true" do
        subject = Subject.new(@attr)
        if subject.typesubject.room == true
          subject.room = nil
          subject.should_not be_valid
        end
      end
      
      it "should be valida if typesubject.room == true" do
        subject = Subject.new(@attr.merge(:typesubject_id => @withoutroom.id))
        subject.room = nil
        subject.should be_valid
      end
    end
    
    describe "validate price currency" do
      it "should require price_currency" do
        subject = Subject.new(@attr.merge(:price_currency => nil))
        subject.should_not be_valid
      end
    end
    
  end
  
  describe "associations" do
    describe "typesubject" do
      it "should respond to typesubject" do
        subject = Subject.new(@attr)
        subject.should respond_to(:typesubject)
      end
      
      it "should belongs_to to typesubject" do
        s = Subject.reflect_on_association(:typesubject)
        s.macro.should == :belongs_to
      end
    end
    
    describe "city" do
      it "should respond to city" do
        subject = Subject.new(@attr)
        subject.should respond_to(:city)
      end
      
      it "should belongs_to to city" do
        subject = Subject.reflect_on_association(:city)
        subject.macro.should == :belongs_to
      end
    end
    
    describe "typetransaction" do
      it "should respond to typetransaction" do
        subject = Subject.new(@attr)
        subject.should respond_to(:typetransaction)
      end
      
      it "should belongs_to to typetransaction" do
        subject = Subject.reflect_on_association(:typetransaction)
        subject.macro.should == :belongs_to
      end
    end
    
    describe "customer" do
      it "should respond to customer" do
        subject = Subject.new(@attr)
        subject.should respond_to(:customer)
      end
      
      it "should belongs_to :customer" do
        subject = Subject.reflect_on_association(:customer)
        subject.macro.should == :belongs_to
      end
    end
    
    describe "transaction" do
      
      it "should respond to transaction" do
        subject = Subject.new(@attr)
        subject.should respond_to(:transaction)
      end
      
      it "should has_one transaction" do
        subject = Subject.reflect_on_association(:transaction)
        subject.macro.should == :has_one
      end
      
    end
    
    describe "district" do
      it "should respond to district" do
        subject = Subject.new(@attr)
        subject.should respond_to(:district)
      end
      
      it "should belongs_to :district" do
        subject = Subject.reflect_on_association(:district)
        subject.macro.should == :belongs_to
      end
    end
    
    describe "resident" do
      it "should respond to resident" do
        subject = Subject.new(@attr)
        subject.should respond_to(:resident)
      end
      
      it "should belongs_to :resident" do
        subject = Subject.reflect_on_association(:resident)
        subject.macro.should == :belongs_to
      end
    end
    
    describe "photos" do
      it "should respond to photos" do
        subject = Subject.new(@attr)
        subject.should respond_to(:photos)
      end
      
      it "should has_many :photos" do
        subject = Subject.reflect_on_association(:photos)
        subject.macro.should == :has_many
      end
      
      it "should depent destroy" do
        subject = Subject.reflect_on_association(:photos)
        subject.options[:dependent].should == :destroy
      end
    end
    
    describe "properties" do
      it "shoould respond to properties" do
        subject = Subject.new(@attr)
        subject.should respond_to(:properties)
      end
      
      it "should has_many :properties" do
        subject = Subject.reflect_on_association(:properties)
        subject.macro.should == :has_many
      end
      
      it "should dependent destroy" do
        subject = Subject.reflect_on_association(:properties)
        subject.options[:dependent].should == :destroy
      end
    end
  end
  
  describe "remove properties if typesubject change" do

    it "should remove properties" do
      subject = @subject
      subject.typesubject_id = @withourfloor.id
      subject.save
      subject.properties.should == []
    end
  end
  
  describe "scopes" do
    it "active_subjects scopes should return where(:active => true)" do
      @subjects = Subject.active_subjects
      @subjects.to_sql.should =~ /`active` = 1/i
    end
    
    it "inactive_subjects scopes should return where(:active => false)" do
      @subjects = Subject.inactive_subjects
      @subjects.to_sql.should =~ /`active` = 0/i
    end
  end
  
end

# == Schema Information
#
# Table name: subjects
#
#  id                 :integer(4)      not null, primary key
#  typesubject_id     :integer(4)
#  city_id            :integer(4)
#  price              :integer(4)
#  area               :integer(4)
#  address            :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  typetransaction_id :integer(4)
#  customer_id        :integer(4)
#  district_id        :integer(4)
#  floor              :integer(4)
#  street_src         :string(255)
#  house_src          :string(255)
#  flat_src           :string(255)
#  user_id            :integer(4)
#  active             :boolean(1)      default(TRUE)
#  price_currency     :string(255)
#  room               :integer(4)
#  resident_id        :integer(4)
#  floorall           :integer(4)
#  note               :text
#

