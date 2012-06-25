# -*- encoding : utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :paginator do
    resource "объекты"
    paginate 10
  end
end
