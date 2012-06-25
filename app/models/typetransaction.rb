# -*- encoding : utf-8 -*-
class Typetransaction < ActiveRecord::Base
  has_many :customers
  has_many :subjects
  has_many :transactions
end

# == Schema Information
#
# Table name: typetransactions
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

