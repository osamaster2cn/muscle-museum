FactoryBot.define do
  factory :user do
    ################
    # Base
    ################
    name { "Alice" }
    sequence (:email) { |n| "tester#{n}@example.com" }
    profile_photo { "" }
    password { "123456" }
    password_confirmation { "123456" }

    ################
    # name
    ################
    trait :user_name_blank do
      name { "" }
    end
    trait :user_name_length_49 do
      name { "a" * 49 }
    end
    trait :user_name_length_50 do
      name { "a" * 50 }
    end
    trait :user_name_length_51 do
      name { "a" * 51 }
    end

    ################
    # email
    ################
    trait :user_email_blank do
      email { "" }
    end
    trait :user_email_ng_regex do
      email { "test" }
    end
    trait :user_email_ok_regex do
      email { "test@example.com" }
    end
    trait :user_email_test_1 do
      email { "test1@example.com" }
    end
    trait :user_email_test_2 do
      email { "test2@example.com" }
    end

    ################
    # profile_photo
    ################
    trait :user_profile_photo_blank do
      profile_photo { "" }
    end
    trait :user_profile_photo_1MB do
      profile_photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/1MB.jpg'), 'image/jpg') }
    end
    trait :user_profile_photo_2MB do
      profile_photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/2MB.jpg'), 'image/jpg') }
    end
    trait :user_profile_photo_3MB do
      profile_photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/3MB.jpg'), 'image/jpg') }
    end

    ################
    # password, password_confirmation
    ################
    trait :user_password_and_password_confirmation_blank do
      password { "" }
      password_confirmation { "" }
    end

    trait :user_password_blank do
      password { "" }
    end

    trait :user_password_confirmation_blank do
      password_confirmation { "" }
    end

    trait :user_password_and_password_confirmation_length_5 do
      password { "12345" }
      password_confirmation { "12345" }
    end

    trait :user_password_and_password_confirmation_length_6 do
      password { "123456" }
      password_confirmation { "123456" }
    end

    trait :user_password_and_password_confirmation_length_7 do
      password { "1234567" }
      password_confirmation { "1234567" }
    end

  end
end
