# -*- encoding : utf-8 -*-
class Website::Advice < ActiveRecord::Base
  
  # validations:
  validates :title, :presence => true
  validates :body, :presence => true
  validates :author, :presence => true
end
