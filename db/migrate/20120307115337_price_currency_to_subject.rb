# -*- encoding : utf-8 -*-
class PriceCurrencyToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :price_currency, :string
  end
end
