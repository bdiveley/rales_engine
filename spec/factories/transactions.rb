FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { "1223456" }
    credit_card_expiration_date { "" }
    result { "success" }
  end
end
