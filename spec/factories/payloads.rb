FactoryBot.define do
  factory :payload, class: Hash do
    user_id { 1 }
    title { "Title" }
    tags { [] }

    initialize_with { attributes }
  end
end
