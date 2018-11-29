FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "Item Name #{n}"}
    description { "MyText" }
    unit_price { "9.99" }
    merchant { nil }
  end
end
