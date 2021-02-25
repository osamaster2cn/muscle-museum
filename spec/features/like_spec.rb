require 'rails_helper'

RSpec.feature "Likes", type: :feature do

  before do
    visit root_path
    within '.jumbotron' do
      click_on "ログイン"
    end

    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_on "ログインする"

  end

  context "#create" do

    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }

    it "「いいね」ができること", js: true do

      visit post_path(post)
      expect {
        find(".love").click
        expect(page).to have_content "が「いいね！」しました" # Ajax処理を待つ意味もある
      }.to change(user.likes, :count).by(1)

    end
  end

  context "#destroy" do

    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }
    let!(:like) { create(:like, user_id: user.id, post_id: post.id) }

    it "「いいね」が削除できること", js: true do

      visit post_path(post)
      expect {
        find(".loved").click
        expect(page).not_to have_content "が「いいね！」しました" # Ajax処理を待つ意味もある
      }.to change(user.likes, :count).by(-1)

    end
  end
end
