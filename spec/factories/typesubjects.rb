# -*- encoding : utf-8 -*-

FactoryGirl.define do
  factory :typesubject do
    name "Коттедж"
    permalink "cottage"
    floor true
    room true
    resident true
  end
  
  factory :withourfloor, :class => Typesubject do
    name "Дача"
    permalink "dacha"
    floor false
    room false
    resident true
  end
  
  factory :withcond, :class => Typesubject do
    name "Квартира"
    permalink "flat"
    floor true
    room true
    resident true
  end

  factory :withoutroom, :class => Typesubject do
    name "Частный дом"
    permalink "chastnii dom"
    floor false
    room false
    resident true
  end
  
  factory :withoutresident, :class => Typesubject do
    name "Офис"
    premalink "office"
    floor true
    room true
    resident false
  end
  
end
