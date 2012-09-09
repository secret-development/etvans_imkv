# -*- encoding : utf-8 -*-
#encoding: UTF-8

require 'spec_helper'

describe Task do
  
  before(:each) do
    @user = FactoryGirl.create(:user)
    @task = FactoryGirl.create(:task, :user => @user, :user_lastname => @user.lastname)
    
    @attr = {
      :title => "MyTask",
      :description => "Just to do something",
      :user_id => @user.id,
      :user_lastname => @user.lastname,
      :deadline => "2050-02-08 13:58:15",
      :done => false
    }
  end
  
  describe "validates presence" do
    
    it "should create a new instance given a valid attribute" do
      @task = Task.create!(@attr)
    end
    
    it "should require a title" do
      req_presence_sub(:title).should_not be_valid
    end
    
    it "should require a description" do
      req_presence_sub(:description).should_not be_valid
    end
    
    it "should require user's id" do
      req_presence_sub(:user_id).should_not be_valid
    end
    
    it "should require a deadline" do
      req_presence_sub(:deadline).should_not be_valid
    end
    
    # Require presence task(validates :presence => true)
    def req_presence_sub(par)
      @task = Task.new(@attr.merge(par => ""))
    end
    
  end
  
  describe "other validations" do
    
    it "should require a 'done' field (true or false)" do
      req_inclusion_of(:done).should_not be_valid
    end
    
    it "should reject titles that are too long" do
      long_title = "a" * 141
      long_title_task = Task.new(@attr.merge(:title => long_title))
      long_title_task.should_not be_valid
    end
    
    it "should reject descriptions that are too long" do
      long_description = "a" * 801
      long_description_task = Task.new(@attr.merge(:description => long_description))
      long_description_task.should_not be_valid
    end
    
    it "should reject deadlines that already have passed" do
      passed_deadline = Time.current - 2.days
      passed_deadline_task = Task.new(@attr.merge(:deadline => passed_deadline))
      passed_deadline_task.should_not be_valid
    end
    
    # Require inclusion_of task(validates_inclusion_of :in => [true, false])
    def req_inclusion_of(par)
      @task = Task.new(@attr.merge(par => ""))
    end
    
  end
  
  describe "user associations" do
    
    it "should respond to user" do
      @task = Task.new(@attr)
      @task.should respond_to(:user)
    end
    
    it "should belongs_to user" do
      t = Task.reflect_on_association(:user)
      t.macro.should == :belongs_to
    end
    
  end
  
  describe "helper methods" do
    
    describe "done methods" do
      
      it "should write 'Да ' if done true" do
        @task = Task.new(:task => @attr, :done => true )
        @task.status.should == "Да "
      end
      
      it "should write 'Нет' if done false" do
        @task = Task.new(@attr)
        @task.status.should == "Нет"
      end
      
    end
    
    describe "legend" do
      
      it "should write 'Добавление' if new record" do
        @task = Task.new(@attr)
        @task.legend.should == "Добавление"
      end
      
      it "should write 'Редактирование' if it is not" do
        @task = Task.new(@attr)
        @task.save
        @task.legend.should == "Редактирование"
      end
      
    end
    
    describe "button_value" do
      
      it "should write 'Добавить' if new record" do
        @task = Task.new(@attr)
        @task.button_value.should == "Добавить"
      end
      
      it "should write 'Обновить' if it is not" do
        @task = Task.new(@attr)
        @task.save
        @task.button_value.should == "Обновить"
      end
      
    end
    
    describe "date_for_validation" do
      
      it "should be time.current if new_record" do
        @task = Task.new(@attr)
        @task.date_for_validation.to_s.should == Time.current.to_s
      end
      
      it "should be created_at if it is not" do
        @task = Task.new(@attr)
        @task.save
        @task.date_for_validation.to_s.should == @task.created_at.to_s
      end
      
    end
    
    describe "set_user_lastname" do
      it "should set user_lastname from user.lastname" do
        @task = Task.create(@attr)
        @task.user_lastname.should == @task.user.lastname
      end
    end
    
  end
  
end

# == Schema Information
#
# Table name: tasks
#
#  id            :integer(4)      not null, primary key
#  title         :string(255)
#  description   :text
#  user_id       :integer(4)
#  deadline      :datetime
#  done          :boolean(1)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  admin         :boolean(1)
#  user_lastname :string(255)
#

