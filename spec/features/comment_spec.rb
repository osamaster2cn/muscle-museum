require 'rails_helper'

RSpec.feature "Comments", type: :feature do

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

    it "「コメント」ができること", js: true do

      visit post_path(post)
      expect {
        fill_in "comment_comment" , with: "すごい"
        find('#comment_comment').native.send_key(:return)
        expect(page).to have_content "すごい" # Ajax処理を待つ意味もある
      }.to change(user.comments, :count).by(1)

    end
  end

  context "#destroy" do

    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }
    let!(:comment) { create(:comment, user_id: user.id, post_id: post.id) }

    it "「コメント」が削除できること", js: true do

      visit post_path(post)
      expect {
        find(".delete-comment").click
        expect(page).not_to have_content "すごい" # Ajax処理を待つ意味もある
      }.to change(user.comments, :count).by(-1)

    end
  end
end
