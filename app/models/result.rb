# -*- encoding : utf-8 -*-
class Result < ActiveRecord::Base
  
  def self.typetransaction
    all_typetransactions = Typetransaction.all
    need_transaction = {}
    all_typetransactions.each do |a|
      case a.name
      when "Продажа"
        need_transaction["купить"] = a.id
      when "Аренда"
        need_transaction["снять"] = a.id
      when "Обмен"
        need_transaction["обменять"] = a.id
      end
    end
    return need_transaction
  end
  
end
