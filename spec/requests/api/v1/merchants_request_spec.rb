require "rails_helper"

describe "Merchants API" do
  it 'sends a list of merchants' do
    create_list(:merchant, 5)

    get '/api/v1/merchants'
    merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchants["data"].count).to eq(5)
  end
  it 'sends one merchant' do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"
    item = JSON.parse(response.body)["data"]["attributes"]

    expect(response).to be_successful
    expect(item["id"]).to eq(merchant.id)
    expect(item["name"]).to eq(merchant.name)
  end
  it 'finds one specific merchant based on name query' do
    merchants = create_list(:merchant, 3)
    first_merch = merchants[0]
    second_merch = merchants[1]

    get "/api/v1/merchants/find?name=#{first_merch.name}"
    merchant = JSON.parse(response.body)["data"]["attributes"]

    expect(response).to be_successful
    expect(merchant["id"]).to eq(first_merch.id)
    expect(merchant["name"]).to eq(first_merch.name)
    expect(merchant["id"]).not_to eq(second_merch.id)
    expect(merchant["name"]).not_to eq(second_merch.name)
  end
  it 'finds one specific merchant based on name query with no case sensitivty' do
    merchant = Merchant.create(name: "bailey diveley")

    get "/api/v1/merchants/find?name=Bailey Diveley"
    merchant_found = JSON.parse(response.body)["data"]["attributes"]

    expect(response).to be_successful
    expect(merchant_found["id"]).to eq(merchant.id)
    expect(merchant_found["name"]).to eq(merchant.name)
  end
  it 'finds one specific merchant based on id query' do
    merchants = create_list(:merchant, 3)
    first_merch = merchants[0]
    second_merch = merchants[1]

    get "/api/v1/merchants/find?id=#{first_merch.id}"
    merchant = JSON.parse(response.body)["data"]["attributes"]

    expect(response).to be_successful
    expect(merchant["id"]).to eq(first_merch.id)
    expect(merchant["name"]).to eq(first_merch.name)
    expect(merchant["id"]).not_to eq(second_merch.id)
    expect(merchant["name"]).not_to eq(second_merch.name)
  end
  it 'finds one specific merchant based on created_at query' do
    first_merch = create(:merchant, created_at: '2012-03-27 14:53:58 UTC')
    second_merch = create(:merchant, created_at: '2012-03-27 14:53:59 UTC')

    get "/api/v1/merchants/find?created_at=#{first_merch.created_at}"
    merchant = JSON.parse(response.body)["data"]["attributes"]

    expect(response).to be_successful
    expect(merchant["id"]).to eq(first_merch.id)
    expect(merchant["name"]).to eq(first_merch.name)
    expect(merchant["id"]).not_to eq(second_merch.id)
    expect(merchant["name"]).not_to eq(second_merch.name)
  end
  it 'finds one specific merchant based on updated_at query' do
    first_merch = create(:merchant, updated_at: '2012-03-27 14:53:59 UTC')
    second_merch = create(:merchant, updated_at: '2012-03-27 14:53:58 UTC')

    get "/api/v1/merchants/find?updated_at=#{first_merch.updated_at}"
    merchant = JSON.parse(response.body)["data"]["attributes"]

    expect(response).to be_successful
    expect(merchant["id"]).to eq(first_merch.id)
    expect(merchant["name"]).to eq(first_merch.name)
    expect(merchant["id"]).not_to eq(second_merch.id)
    expect(merchant["name"]).not_to eq(second_merch.name)
  end
  it 'finds all merchants based on name query without case sensitivity' do
    first_merch = create(:merchant, name: "bailey")
    second_merch = create(:merchant, name: "Bailey")

    get "/api/v1/merchants/find_all?name=#{first_merch.name}"

    first_response = JSON.parse(response.body)["data"][0]["attributes"]
    second_response = JSON.parse(response.body)["data"][1]["attributes"]

    expect(response).to be_successful
    expect(first_response["id"]).to eq(first_merch.id)
    expect(first_response["name"]).to eq(first_merch.name)
    expect(second_response["id"]).to eq(second_merch.id)
    expect(second_response["name"]).to eq(second_merch.name)
  end
  it 'finds all merchants based on id query' do
    first_merch = create(:merchant)
    second_merch = create(:merchant)

    get "/api/v1/merchants/find_all?id=#{first_merch.id}"
    first_response = JSON.parse(response.body)["data"][0]["attributes"]

    expect(response).to be_successful
    expect(first_response["id"]).to eq(first_merch.id)
    expect(first_response["name"]).to eq(first_merch.name)
  end
  it 'finds all merchants based on created_at/updated_at query' do
    first_merch = create(:merchant, created_at: '2012-03-27 14:53:58 UTC', updated_at: '2012-03-27 14:53:58 UTC')
    second_merch = create(:merchant, created_at: '2012-03-27 14:53:58 UTC', updated_at: '2012-03-27 14:53:58 UTC')

    get "/api/v1/merchants/find_all?created_at=#{first_merch.created_at}"
    first_response = JSON.parse(response.body)["data"][0]["attributes"]
    second_response = JSON.parse(response.body)["data"][1]["attributes"]

    expect(response).to be_successful
    expect(first_response["id"]).to eq(first_merch.id)
    expect(first_response["name"]).to eq(first_merch.name)
    expect(second_response["id"]).to eq(second_merch.id)
    expect(second_response["name"]).to eq(second_merch.name)

    get "/api/v1/merchants/find_all?updated_at=#{first_merch.updated_at}"
    first_response = JSON.parse(response.body)["data"][0]["attributes"]
    second_response = JSON.parse(response.body)["data"][1]["attributes"]

    expect(response).to be_successful
    expect(first_response["id"]).to eq(first_merch.id)
    expect(first_response["name"]).to eq(first_merch.name)
    expect(second_response["id"]).to eq(second_merch.id)
    expect(second_response["name"]).to eq(second_merch.name)
  end
  it 'finds one random merchant' do
    merchants = create_list(:merchant, 3)
    first_merch = merchants[0]
    second_merch = merchants[1]

    get "/api/v1/merchants/random.json"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
  end
  it 'displays all associated items' do
    merch_1 = create(:merchant)
    merch_2 = create(:merchant)
    item_1 = create(:item, merchant: merch_1)
    item_2 = create(:item, merchant: merch_1)
    item_3 = create(:item, merchant: merch_2)

    get "/api/v1/merchants/#{merch_1.id}/items"
    items = JSON.parse(response.body)
    return_item_1 = items["data"][0]
    return_item_2 = items["data"][1]

    expect(response).to be_successful
    expect(items["data"].count).to eq(2)
    expect(return_item_1["attributes"]["id"]).to eq(item_1.id)
    expect(return_item_2["attributes"]["id"]).to eq(item_2.id)
  end
  it 'displays all associated invoices' do
    merch_1 = create(:merchant)
    merch_2 = create(:merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, merchant: merch_1, customer: customer)
    invoice_2 = create(:invoice, merchant: merch_1, customer: customer)

    get "/api/v1/merchants/#{merch_1.id}/invoices"
    invoices = JSON.parse(response.body)
    return_invoice_1 = invoices["data"][0]
    return_invoice_2 = invoices["data"][1]

    expect(response).to be_successful
    expect(invoices["data"].count).to eq(2)
    expect(return_invoice_1["attributes"]["id"]).to eq(invoice_1.id)
    expect(return_invoice_2["attributes"]["id"]).to eq(invoice_2.id)
  end

  it 'displays all associated invoices' do
    merch_1 = create(:merchant)
    merch_2 = create(:merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, merchant: merch_1, customer: customer)
    invoice_2 = create(:invoice, merchant: merch_1, customer: customer)
    item = create(:item, unit_price: "75107", merchant: merch_1)

    get "/api/v1/items/find_all?unit_price=#{item.unit_price}"
    invoices = JSON.parse(response.body)
    return_invoice_1 = invoices["data"][0]
    return_invoice_2 = invoices["data"][1]

    expect(response).to be_successful
    expect(invoices["data"].count).to eq(2)
    expect(return_invoice_1["attributes"]["id"]).to eq(invoice_1.id)
    expect(return_invoice_2["attributes"]["id"]).to eq(invoice_2.id)
  end
end
