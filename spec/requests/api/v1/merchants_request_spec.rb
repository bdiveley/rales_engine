require "rails_helper"

describe "Merchants API" do
  it 'sends a list of merchants' do
    create_list(:merchant, 5)

    get '/api/v1/merchants'
    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants.count).to eq(5)
  end
  it 'sends one merchant' do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"
    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["id"]).to eq(merchant.id)
    expect(item["name"]).to eq(merchant.name)
  end
  it 'finds one specific merchant based on name query' do
    merchants = create_list(:merchant, 3)
    first_merch = merchants[0]
    second_merch = merchants[1]

    get "/api/v1/merchants/find?name=#{first_merch.name}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(first_merch.id)
    expect(merchant["name"]).to eq(first_merch.name)
    expect(merchant["id"]).not_to eq(second_merch.id)
    expect(merchant["name"]).not_to eq(second_merch.name)
  end
  it 'finds one specific merchant based on name query with no case sensitivty' do
    merchant = Merchant.create(name: "bailey diveley")

    get "/api/v1/merchants/find?name=Bailey Diveley"
    merchant_found = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_found["id"]).to eq(merchant.id)
    expect(merchant_found["name"]).to eq(merchant.name)
  end
end
