# -*- encoding : utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subject do
    price 10000
    area 73
    address "Абая 165, 8"
    floor 3
    floorall 9
    room 3
    active true
    price_currency "доллар"
    note "хорошая квартира"
  end
  
  factory :subject_active_false, :class => Subject do
    price 10000
    area 73
    address "Абая 165, 8"
    floor 7
    floorall 30
    room 4
    active false
    price_currency "доллар"
    note "хорошая квартира 2"
  end
end
