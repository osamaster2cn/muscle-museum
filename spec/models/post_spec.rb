require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "バリデーション" do

    describe "title" do

      context "空白のとき" do
        let(:post) { build(:post, :post_title_blank) }
        it "無効であること" do
          expect(post).not_to be_valid
        end
      end

      context "31文字のとき" do
        let(:post) { build(:post, :post_title_length_31) }
        it "有効であること" do
          expect(post).to be_valid
        end
      end

      context "32文字のとき" do
        let(:post) { build(:post, :post_title_length_32) }
        it "有効であること" do
          expect(post).to be_valid
        end
      end

      context "33文字のとき" do
        let(:post) { build(:post, :post_title_length_33) }
        it "無効であること" do
          expect(post).not_to be_valid
        end
      end
    end

    describe "caption" do
      context "空白のとき" do
        let(:post) { build(:post, :post_caption_blank) }
        it "有効であること" do
          expect(post).to be_valid
        end
      end

      context "139文字のとき" do
        let(:post) { build(:post, :post_caption_length_139) }
        it "有効であること" do
          expect(post).to be_valid
        end
      end

      context "140文字のとき" do
        let(:post) { build(:post, :post_caption_length_140) }
        it "有効であること" do
          expect(post).to be_valid
        end
      end

      context "141文字のとき" do
        let(:post) { build(:post, :post_caption_length_141) }
        it "無効であること" do
          expect(post).not_to be_valid
        end
      end
    end

    describe "photo" do
      context "空白のとき" do
        let(:post) { build(:post, :post_photo_blank) }
        it "無効であること" do
          expect(post).not_to be_valid
        end
      end

      context "2MB以下の画像のとき" do
        let(:post) { build(:post, :post_photo_1MB) }
        it "有効であること" do
          expect(post).to be_valid
        end
      end

      context "2MBの画像のとき" do
        let(:post) { build(:post, :post_photo_2MB) }
        it "有効であること" do
          expect(post).to be_valid
        end
      end

      context "2MB以上の画像のとき" do
        let(:post) { build(:post, :post_photo_3MB) }
        it "ファイルサイズエラーが発生すること" do
          post.valid?
          expect(post.errors[:photo]).to include("を2MB以下のサイズにしてください")
        end
      end
    end

    describe "view_count" do

      context "空白のとき" do
        let(:post) { build(:post, :post_view_count_blank) }
        it "有効であること" do
          expect(post).to be_valid
        end
      end

      context "0のとき" do
        let(:post) { build(:post, :post_view_count_0) }
        it "有効であること" do
          expect(post).to be_valid
        end
      end

      context "1のとき" do
        let(:post) { build(:post, :post_view_count_1) }
        it "有効であること" do
          expect(post).to be_valid
        end
      end
    end

    describe "category_id" do
      before do
        create(:category, :category_id_1)
      end

      context "空白のとき" do
        let(:post) { build(:post, :post_category_id_blank) }
        it "無効であること" do
          expect(post).not_to be_valid
        end
      end

      context "存在するcategory_idのとき" do
        let(:post) { build(:post, :post_category_id_1) }
        it "有効であること" do
          expect(post).to be_valid
        end
      end

      context "存在しないcategory_idのとき" do
        let(:post) { build(:post, :post_category_id_2) }
        it "無効であること" do
          expect(post).not_to be_valid
        end
      end
    end
  end
end
