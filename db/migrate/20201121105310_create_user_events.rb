class CreateUserEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :user_events do |t|
      t.string     :title ,        null: false
      t.text       :body
      t.datetime   :start_time
      t.datetime   :end_time
      t.integer    :day
      t.references :user,          null:false, foreign_key: true
      t.timestamps
    end
  end
end
