# -*- encoding : utf-8 -*-
class Paginator < ActiveRecord::Base
  validates :paginate, :presence => true
  validates :paginate, :numericality => { :greater_than_or_equal_to => 1 }
end
