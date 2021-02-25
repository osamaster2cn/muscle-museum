require 'rails_helper'

RSpec.describe User, type: :model do

  describe "バリデーション" do
    describe "name" do

      context "空白のとき" do
        let(:user) { build(:user, :user_name_blank) }
        it "無効であること" do
          expect(user).not_to be_valid
        end
      end

      context "49文字のとき" do
        let(:user) { build(:user, :user_name_length_49) }
        it "有効であること" do
          expect(user).to be_valid
        end
      end

      context "50文字のとき" do
        let(:user) { build(:user, :user_name_length_50) }
        it "有効であること" do
          expect(user).to be_valid
        end
      end

      context "51文字のとき" do
        let(:user) { build(:user, :user_name_length_51) }
        it "無効であること" do
          expect(user).not_to be_valid
        end
      end
    end

    describe "email" do
      context "空白のとき" do
        let(:user) { build(:user, :user_email_blank) }
        it "無効であること" do
          expect(user).not_to be_valid
        end
      end

      context "正規表現を満たさないemailのとき" do
        let(:user) { build(:user, :user_email_ng_regex) }
        it "無効であること" do
          expect(user).not_to be_valid
        end
      end

      context "正規表現を満たすemailのとき" do
        let(:user) { build(:user, :user_email_ok_regex) }
        it "有効であること" do
          expect(user).to be_valid
        end
      end

      context "重複していないとき" do
        before do
          create(:user, :user_email_test_1)
        end
        let(:user) { build(:user, :user_email_test_2) }
        it "有効であること" do
          expect(user).to be_valid
        end
      end

      context "重複しているとき" do
        before do
          create(:user, :user_email_test_1)
        end
        let(:user) { build(:user, :user_email_test_1) }
        it "無効であること" do
          expect(user).not_to be_valid
        end
      end
    end

    describe "profile_photo" do
      context "空白のとき" do
        let(:user) { create(:user, :user_profile_photo_blank) }
        it "有効であること" do
          expect(user).to be_valid
        end
      end

      context "2MB以下の画像のとき" do
        let(:user) { build(:user, :user_profile_photo_1MB) }
        it "有効であること" do
          expect(user).to be_valid
        end
      end

      context "2MBの画像のとき" do
        let(:user) { build(:user, :user_profile_photo_2MB) }
        it "有効であること" do
          expect(user).to be_valid
        end
      end

      context "2MB以上の画像のとき" do
        let(:user) { build(:user, :user_profile_photo_3MB) }
        it "ファイルサイズエラーが発生すること" do
          user.valid?
          expect(user.errors[:profile_photo]).to include("を2MB以下のサイズにしてください")
        end
      end

    end

    describe "password" do
      context "password、password_confirmationが空白のとき" do
        let(:user) { build(:user, :user_password_and_password_confirmation_blank) }
        it "無効であること" do
          expect(user).not_to be_valid
        end
      end

      context "passwordのみが空白のとき" do
        let(:user) { build(:user, :user_password_blank) }
        it "無効であること" do
          expect(user).not_to be_valid
        end
      end

      context "password_confirmationのみが空白のとき" do
        let(:user) { build(:user, :user_password_confirmation_blank) }
        it "無効であること" do
          expect(user).not_to be_valid
        end
      end

      context "password、password_confirmationが5文字のとき" do
        let(:user) { build(:user, :user_password_and_password_confirmation_length_5) }
        it "無効であること" do
          expect(user).not_to be_valid
        end
      end

      context "password、password_confirmationが6文字のとき" do
        let(:user) { build(:user, :user_password_and_password_confirmation_length_6) }
        it "有効であること" do
          expect(user).to be_valid
        end
      end

      context "password、password_confirmationが7文字のとき" do
        let(:user) { build(:user, :user_password_and_password_confirmation_length_7) }
        it "有効であること" do
          expect(user).to be_valid
        end
      end

    end
  end
end