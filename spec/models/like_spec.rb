require 'rails_helper'

RSpec.describe Like, type: :model do

  describe "post_id" do

    context "空白のとき" do
      let(:like) { build(:like, :like_post_id_blank) }
      it "無効であること" do
        expect(like).not_to be_valid
      end
    end

    context "関連するpost_idが存在する時" do
      let(:like) { build(:like) }
      it "有効であること" do
        expect(like).to be_valid
      end
    end

    context "関連するpost_idが存在しない時" do
      let(:like) { build(:like, :like_post_id_no_rel) }
      it "無効であること" do
        expect(like).not_to be_valid
      end
    end
  end

  describe "user_id" do

    context "空白のとき" do
      let(:like) { build(:like, :like_user_id_blank) }
      it "無効であること" do
        expect(like).not_to be_valid
      end
    end

    context "関連するuser_idが存在する時" do
      let(:like) { build(:like) }
      it "有効であること" do
        expect(like).to be_valid
      end
    end

    context "関連するuser_idが存在しない時" do
      let(:like) { build(:like, :like_user_id_no_rel) }
      it "無効であること" do
        expect(like).not_to be_valid
      end
    end

    context "user_idが重複している時" do
      pending
    end

  end
end
