# -*- encoding : utf-8 -*-
require 'spec_helper'

describe User do
  before(:each) do
    @attr = {
      :email => "agent@mail.ru",
      :password => "password",
      :password_confirmation => "password",
      :lastname => "Петров",
      :firstname => "Петр",
      :phonemobile => "+7 777 747 4343"
    }
  end 
  
  # validation invalid
  describe "invalid validation" do
    
    it "should require email" do
      null_email = User.new(@attr.merge(:email => ""))
      null_email.should_not be_valid    
    end
    
    it " should invalid email" do
      mail = %w[man@ru woman@mail,ru]
      mail.each  do |mail|
        invalid_email = User.new(@attr.merge(:email => mail))
        invalid_email.should_not be_valid
      end    
    end
    
    it "should reject duplicate email" do
      User.create(@attr)
      duplicate_email = User.new(@attr)
      duplicate_email.should_not be_valid    
    end
    
    it "should reject duplicate upcase email" do
      upcase_email = @attr[:email].upcase
      User.create!(@attr.merge(:email => upcase_email))
      user_duplicate_email = User.new(@attr)
      user_duplicate_email.should_not be_valid    
    end
  
    it "should require lastname" do
      not_lastname = User.new(@attr.merge(:lastname => ""))
      not_lastname.should_not be_valid    
    end
    
    it "should require firstname" do
      not_firstname = User.new(@attr.merge(:firstname => ""))
      not_firstname.should_not be_valid      
    end
      
  end
  
  # success validation
  describe "success validation" do
      
    it "should create user" do
      User.create!(@attr)  
    end
    
    it "should accept valid email" do
      mail = %w[man@mail.ru Woman@mail.ru]
      mail.each do |mail|
        valid_email = User.new(@attr.merge(:email => mail))
        valid_email.should be_valid
      end    
    end  
  
  end
  
  describe "test help methods" do
    it "legend value for new" do
      @user = User.new(@attr)
      @user.legend_value.should == "Добавление нового сотрудника"      
    end
    
    it "legend value for update" do
      @update = User.create!(@attr)
      @update.firstname = "Ваня"
      @update.legend_value.should == "Изменение анкетных данных"      
    end
    
  end
  # password reset
  describe "send password reset" do
    let(:user) {FactoryGirl.create(:user)}
    
    it "generate a unique password reset token" do
      user.send_password_reset
      last_token = user.password_reset_token
      user.send_password_reset
      user.password_reset_token.should_not eq(last_token)      
    end
    
    it "saves the time password reset was sent" do
      user.send_password_reset
      user.password_reset_sent_at.should be_present      
    end
    
    it "delivers email to user" do
      user.send_password_reset
      last_email.to.should include(user.email)      
    end    
  end
  
  # associations
  describe "associations" do
    
    describe "transactions" do
      it "should respond to transactions" do
        user = User.new(@attr)
        user.should respond_to(:transactions)
      end
      
      it "should has_many transactions" do
        user = User.reflect_on_association(:transactions)
        user.macro.should == :has_many
      end
      
      it "should dependent nullify" do
        user = User.reflect_on_association(:transactions)
        user.options[:dependent].should == :nullify
      end
    end
    
    describe "customers" do
      it "should respond to customers" do
        user = User.new(@attr)
        user.should respond_to(:customers)
      end
      
      it "should has_many customers" do
        user = User.reflect_on_association(:customers)
        user.macro.should == :has_many
      end
      
      it "should dependent nullify" do
        user = User.reflect_on_association(:customers)
        user.options[:dependent].should == :nullify
      end
    end
    
    describe "tasks" do
      it "should respond to tasks" do
        user = User.new(@attr)
        user.should respond_to(:tasks)
      end
      
      it "should has_many tasks" do
        user = User.reflect_on_association(:tasks)
        user.macro.should == :has_many
      end
      
      it "should dependent nullify" do
        user = User.reflect_on_association(:tasks)
        user.options[:dependent].should == :nullify
      end      
    end
    
    describe "subjects" do
      it "should respond to subjects" do
        user = User.new(@attr)
        user.should respond_to(:subjects)
      end
      
      it "should has_many subjects" do
        user = User.reflect_on_association(:subjects)
        user.macro.should == :has_many
      end
      
      it "should dependent nullify" do
        user = User.reflect_on_association(:subjects)
        user.options[:dependent].should == :nullify
      end
    end
    
  end
  
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  email                  :string(255)
#  password_hash          :string(255)
#  password_salt          :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  auth_token             :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  role                   :boolean(1)
#  firstname              :string(255)
#  lastname               :string(255)
#  phonemobile            :string(255)
#  phonehome              :string(255)
#  fired                  :boolean(1)      default(FALSE)
#  last_sign_in_at        :datetime
#

