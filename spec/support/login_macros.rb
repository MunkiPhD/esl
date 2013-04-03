module LoginMacros
  def login_user(user)
    visit root_path

    click_link "login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Sign in"
  end
end
