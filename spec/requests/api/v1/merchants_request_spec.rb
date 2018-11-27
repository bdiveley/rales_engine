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
  xit 'finds one specific merchant based on find parameter' do
    merchants = create_list(:merchant, 3)
    first_merch = merchants[0]

    get "/api/v1/merchants/find?name=#{first_merch.name}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(first_merch.id)
    expect(merchant["name"]).to eq(first_merch.name)
  end
end
