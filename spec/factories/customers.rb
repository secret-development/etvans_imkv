# -*- encoding : utf-8 -*-

FactoryGirl.define do
  factory :customer do
    firstname      "Ivan"
    lastname       "Ivanov"
    phonehome      "853049853"
    phonemobile    "853049853"
    email          "vanya@mail.ru"
    potentials     false
    note           "bla-bla-bla"
    lastcall       Time.now.weeks_ago(1)
  end
  
  factory :customer_pot, :class => Customer do
    firstname      "Sam"
    lastname       "Samov"
    phonehome      "853049853"
    phonemobile    "853049853"
    email          "de@mail.ru"
    potentials     true
    note           "bla-ded-bla"
    lastcall       Time.now.weeks_ago(1)
  end
end
