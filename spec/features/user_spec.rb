require 'rails_helper'

RSpec.describe "Users", type: :feature do

  let(:user) { create(:user) }

  it "新規登録できること" do

    visit root_path
    click_on "新規登録"

    fill_in "メールアドレス", with: "system@system.com"
    fill_in "名前", with: "Bob"
    fill_in "パスワード", with: "123456"
    fill_in "パスワード（確認用）", with: "123456"

    click_on "登録する"
    expect(page).to have_content "アカウント登録が完了しました"
    expect(page).to have_current_path root_path

  end

  it "ログインできること" do

    visit root_path
    within '.jumbotron' do
      click_on "ログイン"
    end

    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_on "ログインする"

    expect(page).to have_content "ログインしました"
    expect(page).to have_current_path root_path

  end

  # it "パスワード再設定" do
  #  
  # end

  it "ログアウトできること" do

    visit root_path
    within '.jumbotron' do
      click_on "ログイン"
    end

    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_on "ログインする"

    within '.navbar' do
      click_on "ログアウト"
    end

    within '.modal' do
      click_on "ログアウト"
    end

    expect(page).to have_content "ログアウトしました"
    expect(page).to have_current_path root_path

  end

  it "編集できること" do

    visit root_path
    within '.jumbotron' do
      click_on "ログイン"
    end

    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_on "ログインする"

    within '.navbar' do
      click_on "プロフィール"
    end

    find(".setting").click

    attach_file 'プロフィール画像', "#{Rails.root}/spec/fixtures/sample1.jpg"
    fill_in "名前", with: "タナカタロウ"
    fill_in "メールアドレス", with: "tanaka@tanaka.com"
    click_on "変更する"

    expect(page).to have_content "アカウント情報を変更しました"
    expect(page).to have_content "タナカタロウ"
    expect(page).to have_current_path user_path(user)

  end

end
