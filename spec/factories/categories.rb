FactoryBot.define do
  factory :category do
    category_name { "アニメ" }

    trait :category_id_1 do id { 1 } end
  end
end
