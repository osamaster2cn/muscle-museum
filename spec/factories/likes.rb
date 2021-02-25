FactoryBot.define do
  factory :like do
    ################
    # Base
    ################
    association :post, factory: :post, strategy: :create
    association :user, factory: :user, strategy: :create

    ################
    # post_id
    ################
    trait :like_post_id_blank do
      post_id { "" }
    end

    trait :like_post_id_no_rel do
      post_id { 100 }
    end

    ################
    # user_id
    ################
    trait :like_user_id_blank do
      user_id { "" }
    end

    trait :like_user_id_no_rel do
      user_id { 100 }
    end

  end
end
