# -*- encoding : utf-8 -*-
class AddPriceCurrencyToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :price_currency, :string
  end
end
