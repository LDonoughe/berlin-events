# frozen_string_literal: true

class AddStartAndEndDate < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :start, :datetime
    add_column :events, :last, :datetime # both last and end are bad names for this. Consider renaming start_date, end_date
  end
end
