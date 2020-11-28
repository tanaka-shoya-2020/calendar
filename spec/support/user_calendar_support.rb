module UserCalendarSupport
  def user_calendar(user_event)
    visit new_calendar_path
    expect(current_path).to eq new_calendar_path
    fill_in 'user_event[title]', with: user_event.title
    # 開始時刻の入力
    fill_in 'user_event[start_time]', with: user_event.start_time
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
