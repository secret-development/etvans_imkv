# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Photo do
  before(:each) do
    @city = Factory(:city)
    @typesubject = Factory(:typesubject)
    @district = Factory(:district)
    @customer = Factory(:customer)
    @subject = Factory(:subject, :typesubject => @typesubject, :city => @city, 
        :customer => @customer, :district => @district)
    @photo = Factory(:photo, :subject => @subject)
    @attr = {
      :subject_id => @subject.id,
      :image => "ls.png"
    }
  end
  describe "associations" do
    describe "subject" do
      it "should respond to subject" do
        photo = Photo.new(@attr)
        photo.should respond_to(:subject)
      end
      
      it "should belongs_to :subject" do
        photo = Photo.reflect_on_association(:subject)
        photo.macro.should == :belongs_to
      end
    end
  end
end

# == Schema Information
#
# Table name: photos
#
#  id         :integer(4)      not null, primary key
#  subject_id :integer(4)
#  image      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

