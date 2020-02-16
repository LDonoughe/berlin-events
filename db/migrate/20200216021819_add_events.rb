# frozen_string_literal: true

class AddEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :when
      t.string :description
      t.string :source

      t.timestamps
    end
  end
end
