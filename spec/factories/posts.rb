FactoryBot.use_parent_strategy = false

FactoryBot.define do
  ################
  # Base
  ################
  factory :post do
    title { "タイトル" }
    caption { "説明文" }
    photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample1.jpg'), 'image/jpeg') }
    view_count { 1 }
    association :user, factory: :user, strategy: :create
    association :category, factory: :category, strategy: :create

    ################
    # title
    ################
    trait :post_title_blank do
      title { "" }
    end
    trait :post_title_length_31 do
      title { "a" * 31 }
    end
    trait :post_title_length_32 do
      title { "a" * 32 }
    end
    trait :post_title_length_33 do
      title { "a" * 33 }
    end

    ################
    # caption
    ################
    trait :post_caption_blank do
      caption { "" }
    end
    trait :post_caption_length_139 do
      caption { "a" * 139 }
    end
    trait :post_caption_length_140 do
      caption { "a" * 140 }
    end
    trait :post_caption_length_141 do
      caption { "a" * 141 }
    end

    ################
    # photo
    ################
    trait :post_photo_blank do
      photo { "" }
    end
    trait :post_photo_1MB do
      photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/1MB.jpg'), 'image/jpg') }
    end
    trait :post_photo_2MB do
      photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/2MB.jpg'), 'image/jpg') }
    end
    trait :post_photo_3MB do
      photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/3MB.jpg'), 'image/jpg') }
    end

    ################
    # view_count
    ################
    trait :post_view_count_blank do
      view_count { "" }
    end
    trait :post_view_count_0 do
      view_count { 0 }
    end
    trait :post_view_count_1 do
      view_count { 1 }
    end

    ################
    # category_id
    ################
    trait :post_category_id_blank do
      category_id { "" }
    end
    trait :post_category_id_1 do
      category_id { 1 }
    end
    trait :post_category_id_2 do
      category_id { 2 }
    end

  end

end
