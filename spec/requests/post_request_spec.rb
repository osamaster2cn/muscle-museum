require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "#index" do
    context "投稿者" do
      let(:user) { create(:user) }
      it "正常にレスポンスを返すこと" do
        sign_in user
        get :index
        expect(response).to be_successful
      end

      it "200レスポンスを返すこと" do
        sign_in user
        get :index
        expect(response).to have_http_status "200"
      end
    end

    context "会員" do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }
      it "正常にレスポンスを返すこと" do
        sign_in other_user
        get :index
        expect(response).to be_successful
      end

      it "200レスポンスを返すこと" do
        sign_in other_user
        get :index
        expect(response).to have_http_status "200"
      end
    end

    context "非会員" do
      it "正常にレスポンスを返すこと" do
        get :index
        expect(response).to be_successful
      end

      it "200レスポンスを返すこと" do
        get :index
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "#show" do
    context "投稿者" do
      let(:user) { create(:user) }
      let(:post) { create(:post, user: user) }
      it "正常にレスポンスを返すこと" do
        sign_in user
        get :show, params: { id: post.id }
        expect(response).to be_successful
      end

      it "200レスポンスを返すこと" do
        sign_in user
        get :show, params: { id: post.id }
        expect(response).to have_http_status "200"
      end
    end

    context "会員" do
      let(:user) { create(:user) }
      let(:post) { create(:post, user: user) }
      let(:other_user) { create(:user) }
      it "正常にレスポンスを返すこと" do
        sign_in other_user
        get :show, params: { id: post.id }
        expect(response).to be_successful
      end

      it "200レスポンスを返すこと" do
        sign_in other_user
        get :show, params: { id: post.id }
        expect(response).to have_http_status "200"
      end
    end

    context "非会員" do
      let(:user) { create(:user) }
      let(:post) { create(:post, user: user) }
      it "正常にレスポンスを返すこと" do
        get :show, params: { id: post.id }
        expect(response).to be_successful
      end

      it "200レスポンスを返すこと" do
        get :show, params: { id: post.id }
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "#create" do
    context "投稿者" do

      let(:user) { create(:user) }
      let(:category) { create(:category) }

      context "有効な属性値の場合" do
        it "画像を投稿できること" do
          sign_in user
          post_params = attributes_for(:post, user_id: user.id, category_id: category.id)
          expect {
            post :create, params: { post: post_params }
          }.to change(user.posts, :count).by(1)
        end
      end

      context "無効な属性値の場合" do
        it "画像を投稿できないこと" do
          sign_in user
          post_params = attributes_for(:post, :post_title_blank, user_id: user.id, category_id: category.id)
          expect {
            post :create, params: { post: post_params }
          }.to change(user.posts, :count).by(0)
        end
      end
    end

    context "会員" do

      let(:user) { create(:user) }
      let(:category) { create(:category) }
      let(:other_user) { create(:user) }

      it "投稿者idの画像は投稿できないこと" do
        sign_in other_user
        post_params = attributes_for(:post, user_id: user.id, category_id: category.id)
        expect {
          post :create, params: { post: post_params }
        }.to change(user.posts, :count).by(0)
      end
    end

    context "非会員" do

      let(:user) { create(:user) }
      let(:category) { create(:category) }

      it "302レスポンスを返すこと" do
        post_params = attributes_for(:post, user_id: user.id, category_id: category.id)
        post :create, params: { post: post_params }
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトすること" do
        post_params = attributes_for(:post, user_id: user.id, category_id: category.id)
        post :create, params: { post: post_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#destroy" do
    context "投稿者" do

      let!(:user) { create(:user) }
      let!(:post) { create(:post, user: user) }

      it "画像を削除できること" do
        sign_in user
        expect {
          delete :destroy, params: { id: post.id }
        }.to change(user.posts, :count).by(-1)
      end
    end

    context "会員" do

      let!(:user) { create(:user) }
      let!(:post) { create(:post, user: user) }
      let(:other_user) { create(:user) }

      it "投稿者idの画像は削除できないこと" do
        sign_in other_user
        expect {
          delete :destroy, params: { id: post.id }
        }.to change(user.posts, :count).by(0)
      end

      it "トップページにリダイレクトされる事" do
        sign_in other_user
        delete :destroy, params: { id: post.id }
        expect(response).to redirect_to root_path
      end

    end

    context "非会員" do

      let!(:user) { create(:user) }
      let!(:post) { create(:post, user: user) }

      it "302レスポンスを返すこと" do
        delete :destroy, params: { id: post.id }
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトすること" do
        delete :destroy, params: { id: post.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end


end