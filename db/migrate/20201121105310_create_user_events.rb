class CreateUserEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :user_events do |t|
      t.string     :title ,        null: false
      t.text       :body
      t.boolean    :disp_flg
      t.datetime   :start
      t.datetime   :end
      t.string     :allDay
      t.references :user,          null:false, foreign_key: true
      t.timestamps
    end
  end
end
