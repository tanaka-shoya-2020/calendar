class CreateTeamEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :team_events do |t|
      t.string     :title ,        null: false
      t.text       :body
      t.boolean    :disp_flg
      t.datetime   :event_start
      t.datetime   :event_end
      t.string     :allDay
      t.references :team,          null:false, foreign_key: true
      t.timestamps
    end
  end
end
