module TeamCalendarSupport
  def team_calendar(team_event)
    visit new_calendar_path
    # 予定作成画面へ遷移したことを確認する
    expect(current_path).to eq new_calendar_path
    # タイトルを入力
    fill_in 'team_event[title]', with: team_event.title
    # 開始時刻の選択
    find('#team_event_start_time_1i').find("option[value='2020']").select_option
    find('#team_event_start_time_2i').find("option[value='11']").select_option
    find('#team_event_start_time_3i').find("option[value='25']").select_option
    find('#team_event_start_time_4i').find("option[value='12']").select_option
    find('#team_event_start_time_5i').find("option[value='00']").select_option
    # 終了時刻の選択
    find('#team_event_end_time_4i').find("option[value='13']").select_option
    find('#team_event_end_time_5i').find("option[value='00']").select_option
    sleep 1
    # 詳細の入力
    fill_in 'team_event[body]', with: team_event.body
    # 作成するボタンをクリックするとTeamEventモデルのカウント数が1増えることを確認する
    expect { find('input.btn-black').click }.to change { TeamEvent.count }.by(1)
  end
end
