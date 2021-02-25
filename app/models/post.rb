class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :user_id, presence: true
  validates :photo, presence: { message: 'を選択してください' }
  validates :title, presence: true, length: { maximum: 32 }
  validates :caption, length: { maximum: 140 }
  # validates :category_id, presence: { message: 'を選択してください' }

  mount_uploader :photo, PhotoUploader

  def liked_by(user)
    # user_idとpost_idが一致するlikeを検索する
    Like.find_by(user_id: user.id, post_id: id)
  end

  private

end
