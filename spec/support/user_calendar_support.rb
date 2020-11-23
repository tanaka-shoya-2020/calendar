module UserCalendarSupport
  def user_calendar(user_event)
    visit new_calendar_path
    expect(current_path).to eq new_calendar_path
    fill_in 'user_event[title]', with: user_event.title
    # 開始時刻の選択
    find('#user_event_start_time_1i').find("option[value='2020']").select_option
    find('#user_event_start_time_2i').find("option[value='11']").select_option
    find('#user_event_start_time_3i').find("option[value='25']").select_option
    find('#user_event_start_time_4i').find("option[value='12']").select_option
    find('#user_event_start_time_5i').find("option[value='00']").select_option
    # 終了時刻の選択
    find('#user_event_end_time_4i').find("option[value='13']").select_option
    find('#user_event_end_time_5i').find("option[value='00']").select_option
    sleep 1
    # 詳細の入力
    fill_in 'user_event[body]', with: @user_event.body
    # 作成するボタンをクリックするとUserEventモデルのカウント数が1増えることを確認する
    expect { find('input.btn-black').click }.to change { UserEvent.count }.by(1)
    # カレンダー画面に遷移していることを確認する
    expect(current_path).to eq calendars_path
    # カレンダー画面に先ほど作成した予定が記入されていることを確認する
    expect(page).to have_content(@user_event.title.to_s)
  end
end
