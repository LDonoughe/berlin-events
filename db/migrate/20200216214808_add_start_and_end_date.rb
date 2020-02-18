# frozen_string_literal: true

class AddStartAndEndDate < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :start, :datetime
    add_column :events, :last, :datetime
  end
end
