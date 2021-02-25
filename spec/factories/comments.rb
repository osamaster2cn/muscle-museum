FactoryBot.define do
  factory :comment do
    ################
    # Base
    ################
    comment { "すごい" }
    association :post, factory: :post, strategy: :create
    association :user, factory: :user, strategy: :create

    ################
    # comment
    ################
    trait :comment_comment_blank do
      comment { "" }
    end

    trait :comment_comment_length_99 do
      comment { "a"*99 }
    end

    trait :comment_comment_length_100 do
      comment { "a"*100 }
    end

    trait :comment_comment_length_101 do
      comment { "a"*101 }
    end

    ################
    # post_id
    ################
    trait :comment_post_id_blank do
      post_id { "" }
    end

    trait :comment_post_id_no_rel do
      post_id { 100 }
    end

    ################
    # user_id
    ################
    trait :comment_user_id_blank do
      user_id { "" }
    end

    trait :comment_user_id_no_rel do
      user_id { 100 }
    end


  end
end
