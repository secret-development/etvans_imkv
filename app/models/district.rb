# -*- encoding : utf-8 -*-
class District < ActiveRecord::Base
  # associations:
  belongs_to :city
  has_many :subjects, :dependent => :nullify
  # validations:
  validates :title, :presence => true
  validates :title, :uniqueness => {
    :scope => [:city_id],
    :case_sensitive => false
  }
  
  # scopes
  default_scope order("title ASC")
end
# == Schema Information
#
# Table name: districts
#
#  id         :integer(4)      not null, primary key
#  city_id    :integer(4)
#  title      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

