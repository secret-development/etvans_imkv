# -*- encoding : utf-8 -*-
class Resident < ActiveRecord::Base
  # associations:
  belongs_to :city
  has_many :subjects, :dependent => :nullify
  # validates
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
# Table name: residents
#
#  id      :integer(4)      not null, primary key
#  title   :string(255)
#  city_id :integer(4)
#

