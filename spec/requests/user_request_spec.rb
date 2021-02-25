require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#show" do
    context "投稿者" do
      let(:user) { create(:user) }
      it "正常にレスポンスを返すこと" do
        sign_in user
        get :show, params: { id: user.id }
        expect(response).to be_successful
      end

      it "200レスポンスを返すこと" do
        sign_in user
        get :show, params: { id: user.id }
        expect(response).to have_http_status "200"
      end
    end

    context "会員" do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }
      it "正常にレスポンスを返すこと" do
        sign_in other_user
        get :show, params: { id: user.id }
        expect(response).to be_successful
      end

      it "200レスポンスを返すこと" do
        sign_in other_user
        get :show, params: { id: user.id }
        expect(response).to have_http_status "200"
      end
    end

    context "非会員" do
      let(:user) { create(:user) }
      it "正常にレスポンスを返すこと" do
        get :show, params: { id: user.id }
        expect(response).to be_successful
      end

      it "200レスポンスを返すこと" do
        get :show, params: { id: user.id }
        expect(response).to have_http_status "200"
      end
    end
  end
end
