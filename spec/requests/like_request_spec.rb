require 'rails_helper'

RSpec.describe LikesController, type: :controller do

  describe "#create" do
    context "投稿者" do

      let!(:user) { create(:user) }
      let!(:new_post) { create(:post, user: user) }

      before do
        sign_in user
      end

      it "jsフォーマットであること" do
        post :create, format: :js, params: { post_id: new_post.id }
        expect(response.content_type).to eq 'text/javascript; charset=utf-8'
      end

      it "「いいね」ができること" do
        expect {
          post :create, format: :js, params: { post_id: new_post.id }
        }.to change(user.likes, :count).by(1)
      end

      it "存在しない投稿に「いいね」ができないこと" do
        expect {
          post :create, format: :js, params: { post_id: 99999 }
        }.to change(user.likes, :count).by(0)
      end

    end

    context "会員" do

      let!(:user) { create(:user) }
      let!(:new_post) { create(:post, user: user) }
      let!(:other_user) { create(:user) }

      before do
        sign_in other_user
      end

      it "jsフォーマットで返却すること" do
        post :create, format: :js, params: { post_id: new_post.id }
        expect(response.content_type).to eq 'text/javascript; charset=utf-8'
      end

      it "「いいね」ができること" do
        expect {
          post :create, format: :js, params: { post_id: new_post.id }
        }.to change(other_user.likes, :count).by(1)
      end

      it "存在しない投稿に「いいね」ができないこと" do
        expect {
          post :create, format: :js, params: { post_id: 99999 }
        }.to change(other_user.likes, :count).by(0)
      end

    end

    context "非会員" do

      let!(:user) { create(:user) }
      let!(:new_post) { create(:post, user: user) }

      it "401レスポンスを返すこと" do
        post :create, format: :js, params: { post_id: new_post.id }
        expect(response).to have_http_status "401"
      end

    end
  end

  describe "#destory" do

    context "投稿者" do

      let!(:user) { create(:user) }
      let!(:new_post) { create(:post, user: user) }
      let!(:like) { create(:like, user_id: user.id, post_id: new_post.id) }

      before do
        sign_in user
      end

      it "jsフォーマットで返却すること" do
        delete :destroy, format: :js, params: { post_id: new_post.id , id: like.id}
        expect(response.content_type).to eq 'text/javascript; charset=utf-8'
      end

      it "「いいね」を削除できること" do
        expect {
          delete :destroy, format: :js, params: { post_id: new_post.id , id: like.id}
        }.to change(user.likes, :count).by(-1)
      end
    end

  end

  context "会員" do

    let!(:user) { create(:user) }
    let!(:new_post) { create(:post, user: user) }
    let!(:other_user) { create(:user) }
    let!(:like) { create(:like, user_id: other_user.id, post_id: new_post.id) }


    before do
      sign_in other_user
    end

    it "jsフォーマットで返却すること" do
      delete :destroy, format: :js, params: { post_id: new_post.id , id: like.id}
      expect(response.content_type).to eq 'text/javascript; charset=utf-8'
    end

    it "「いいね」を削除できること" do
      expect {
        delete :destroy, format: :js, params: { post_id: new_post.id , id: like.id}
      }.to change(other_user.likes, :count).by(-1)
    end

  end

  context "非会員" do

    let!(:user) { create(:user) }
    let!(:new_post) { create(:post, user: user) }
    let!(:like) { create(:like, user_id: user.id, post_id: new_post.id) }

    it "401レスポンスを返すこと" do
      delete :destroy, format: :js, params: { post_id: new_post.id , id: like.id}
      expect(response).to have_http_status "401"
    end
  end

end
