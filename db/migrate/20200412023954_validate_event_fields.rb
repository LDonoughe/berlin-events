# frozen_string_literal: true

class ValidateEventFields < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:events, :title, false)
    rename_column(:events, :when, :timing)
    change_column_null(:events, :timing, false)
    change_column_null(:events, :description, false)
    change_column_null(:events, :source, false)
    change_column_null(:events, :start, false)
    change_column_null(:events, :last, false)
    change_column_null(:events, :url, false)
  end
end
