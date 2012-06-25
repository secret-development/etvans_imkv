# -*- encoding : utf-8 -*-
class Customeraccess < ActiveRecord::Base
  def self.types
    {"Всем" => true, "Ведущим риэлторам" => false}
  end
end
