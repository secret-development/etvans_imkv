# -*- encoding : utf-8 -*-

FactoryGirl.define do
  factory :property do
    condition "Интернет"
    value "Да"
    typefield "select"
  end
end
