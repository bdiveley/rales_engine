FactoryBot.define do
  factory :invoice_item do
    item { nil }
    invoice { nil }
    quantity { "" }
    unit_price { 1 }
  end
end
