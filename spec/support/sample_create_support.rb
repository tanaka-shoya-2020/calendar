module SampleCreateSupport
  def sample_create(sample)
    visit new_sample_path
    expect(current_path).to eq new_sample_path
    fill_in 'sample_title', with: sample.title
    # 開始時刻の入力
    fill_in 'sample_start_time', with: @sample.start_time
    sleep 1
    # 詳細の入力
    fill_in 'sample_body', with: @sample.body
    # 作成するボタンをクリックするとUserEventモデルのカウント数が1増えることを確認する
    expect { find('input.btn-black').click }.to change { Sample.count }.by(1)
    # カレンダー画面に遷移していることを確認する
    expect(current_path).to eq samples_path
    # カレンダー画面に先ほど作成した予定が記入されていることを確認する
    expect(page).to have_link(@sample.title.to_s)
  end
end
