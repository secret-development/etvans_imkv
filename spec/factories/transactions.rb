# -*- encoding : utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    name "MyString"
    description "MyText"
    price 100000
    payment false
    price_currency "доллар"
  end
end
