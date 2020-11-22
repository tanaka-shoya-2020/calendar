module TeamSignInSupport
  def team_sign_in(team)
    visit new_team_session_path
    fill_in 'team[email]', with: @team.email
    fill_in 'team[password]', with: @team.password
    find('input.btn-black').click 
    expect(current_path).to eq calendars_path
  end
end