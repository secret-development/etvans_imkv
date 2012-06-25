# -*- encoding : utf-8 -*-
module SubjectsHelper

  def room?(object)
    if object.new_record?
      begin
        typesubject = Typesubject.first
        typesubject.room == true
      rescue NoMethodError
        redirect_to customers_path, :alert => "Заполните типы недвижимости"
      end
    else
      object.typesubject.room == true
    end
  end

  def floor?(object)
    if object.new_record?
      begin
        typesubject = Typesubject.first
        typesubject.floor == true  
      rescue NoMethodError  
      end
    else
      object.typesubject.floor == true
    end
  end  
    
end
