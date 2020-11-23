class CreateSamples < ActiveRecord::Migration[6.0]
  def change
    create_table :samples do |t|
      t.string     :title ,        null: false
      t.text       :body
      t.datetime   :start_time
      t.datetime   :end_time
      t.integer    :day
      t.timestamps
    end
  end
end
