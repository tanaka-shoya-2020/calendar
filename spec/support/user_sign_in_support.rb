module UserSignInSupport
  def user_sign_in(_user)
    visit new_user_session_path
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    find('input.btn-black').click
    expect(current_path).to eq calendars_path
  end
end
