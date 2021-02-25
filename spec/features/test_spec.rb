require 'rails_helper'

RSpec.feature "Tests", type: :feature do

  scenario "ユーザがログインを行う" do
    user = FactoryBot.create(:user)

    visit root_path
    within '.jumbotron' do
      click_link "ログイン"
    end

    # within '.navbar' do
    #   click_link "ログイン"
    # end

    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログインする"

    expect(page).to have_content "ログインしました"

  end
end
