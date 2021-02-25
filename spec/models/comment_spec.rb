require 'rails_helper'

RSpec.describe Comment, type: :model do

  describe "comment" do
    context "空白のとき" do
      let(:comment) { build(:comment, :comment_comment_blank) }
      it "無効であること" do
        expect(comment).not_to be_valid
      end
    end

    context "99文字のとき" do
      let(:comment) { build(:comment, :comment_comment_length_99) }
      it "有効であること" do
        expect(comment).to be_valid
      end
    end

    context "100文字のとき" do
      let(:comment) { build(:comment, :comment_comment_length_100) }
      it "有効であること" do
        expect(comment).to be_valid
      end
    end

    context "101文字のとき" do
      let(:comment) { build(:comment, :comment_comment_length_101) }
      it "無効であること" do
        expect(comment).not_to be_valid
      end
    end
  end

  describe "post_id" do

    context "空白のとき" do
      let(:comment) { build(:comment, :comment_post_id_blank) }
      it "無効であること" do
        expect(comment).not_to be_valid
      end
    end

    context "関連するpost_idが存在する時" do
      let(:comment) { build(:comment) }
      it "有効であること" do
        expect(comment).to be_valid
      end
    end

    context "関連するpost_idが存在しない時" do
      let(:comment) { build(:comment, :comment_post_id_no_rel) }
      it "無効であること" do
        expect(comment).not_to be_valid
      end
    end
  end

  describe "user_id" do

    context "空白のとき" do
      let(:comment) { build(:comment, :comment_user_id_blank) }
      it "無効であること" do
        expect(comment).not_to be_valid
      end
    end

    context "関連するuser_idが存在する時" do
      let(:comment) { build(:comment) }
      it "有効であること" do
        expect(comment).to be_valid
      end
    end

    context "関連するuser_idが存在しない時" do
      let(:comment) { build(:comment, :comment_user_id_no_rel) }
      it "無効であること" do
        expect(comment).not_to be_valid
      end
    end
  end
end