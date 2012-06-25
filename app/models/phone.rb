# -*- encoding : utf-8 -*-
class Phone < ActiveRecord::Base
  # associations:
  belongs_to :customer
end
