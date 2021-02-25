require 'rails_helper'

RSpec.describe "Posts", type: :feature do

  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let!(:category) { create(:category) }

  before do
    visit root_path
    within '.jumbotron' do
      click_on "ログイン"
    end

    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_on "ログインする"
  end

  it "投稿できること" do

    within '.navbar' do
      click_on "投稿する"
    end

    expect {
      attach_file '画像', "#{Rails.root}/spec/fixtures/sample1.jpg"
      fill_in "タイトル", with: "進撃の巨人"
      fill_in "説明文", with: "ライナァァァ"
      select "アニメ", from: "post_category_id"

      click_on "投稿"

      expect(page).to have_content "投稿が保存されました"
      expect(page).to have_current_path root_path
    }.to change(user.posts, :count).by(1)

  end

  it "投稿した画像を閲覧できること" do

    visit post_path(post)
    expect(page).to have_current_path post_path(post)

  end

  it "投稿した画像を削除できること" do

    visit post_path(post)

    expect {
      find(".delete-post-icon").click
      expect(page).to have_content "投稿を削除しました"
      expect(page).to have_current_path root_path
    }.to change(user.posts, :count).by(-1)

  end

end
