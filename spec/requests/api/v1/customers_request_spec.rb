require "rails_helper"

describe 'Customers API' do
  it 'sends a list of merchants' do
    create_list(:customer, 5)

    get '/api/v1/customers'

    customers = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customers["data"].count).to eq(5)
  end
  it 'sends one customer' do
    customer = create(:customer)

    get "/api/v1/customers/#{customer.id}"
    item = JSON.parse(response.body)["data"]["attributes"]

    expect(response).to be_successful
    expect(item["id"]).to eq(customer.id)
    expect(item["first_name"]).to eq(customer.first_name)
  end
  it 'finds one specific customer based on first_name query' do
    customer = create_list(:customer, 3)
    first_cust = customer[0]
    second_cust = customer[1]

    get "/api/v1/customers/find?first_name=#{first_cust.first_name}"
    customer = JSON.parse(response.body)["data"]["attributes"]

    expect(response).to be_successful
    expect(customer["id"]).to eq(first_cust.id)
    expect(customer["first_name"]).to eq(first_cust.first_name)
    expect(customer["id"]).not_to eq(second_cust.id)
    expect(customer["first_name"]).not_to eq(second_cust.first_name)
  end
  it 'finds one specific customer based on last_name query' do
    customer = create_list(:customer, 3)
    first_cust = customer[0]
    second_cust = customer[1]

    get "/api/v1/customers/find?last_name=#{first_cust.last_name}"
    customer = JSON.parse(response.body)["data"]["attributes"]

    expect(response).to be_successful
    expect(customer["id"]).to eq(first_cust.id)
    expect(customer["last_name"]).to eq(first_cust.last_name)
    expect(customer["id"]).not_to eq(second_cust.id)
    expect(customer["last_name"]).not_to eq(second_cust.last_name)
  end
  it 'finds one specific customer based on name query with no case sensitivty' do
    customer = Customer.create(first_name: "bailey", last_name: "diveley")

    get "/api/v1/customers/find?first_name=Bailey"
    customer_found = JSON.parse(response.body)["data"]["attributes"]

    expect(response).to be_successful
    expect(customer_found["id"]).to eq(customer.id)
    expect(customer_found["first_name"]).to eq(customer.first_name)
  end
  it 'finds one specific customer based on id query' do
    customers = create_list(:customer, 3)
    first_cust = customers[0]
    second_cust = customers[1]

    get "/api/v1/customers/find?id=#{first_cust.id}"
    customer = JSON.parse(response.body)["data"]["attributes"]

    expect(response).to be_successful
    expect(customer["id"]).to eq(first_cust.id)
    expect(customer["first_name"]).to eq(first_cust.first_name)
    expect(customer["id"]).not_to eq(second_cust.id)
    expect(customer["first_name"]).not_to eq(second_cust.first_name)
  end
  it 'finds one specific customer based on created_at query' do
    first_cust = create(:customer, created_at: '2012-03-27 14:53:58 UTC')
    second_cust = create(:customer, created_at: '2012-03-27 14:53:59 UTC')

    get "/api/v1/customers/find?created_at=#{first_cust.created_at}"
    customer = JSON.parse(response.body)["data"]["attributes"]

    expect(response).to be_successful
    expect(customer["id"]).to eq(first_cust.id)
    expect(customer["first_name"]).to eq(first_cust.first_name)
    expect(customer["id"]).not_to eq(second_cust.id)
    expect(customer["first_name"]).not_to eq(second_cust.first_name)
  end
  it 'finds one specific customer based on updated_at query' do
    first_cust = create(:customer, updated_at: '2012-03-27 14:53:59 UTC')
    second_cust = create(:customer, updated_at: '2012-03-27 14:53:58 UTC')

    get "/api/v1/customers/find?updated_at=#{first_cust.updated_at}"
    customer = JSON.parse(response.body)["data"]["attributes"]

    expect(response).to be_successful
    expect(customer["id"]).to eq(first_cust.id)
    expect(customer["first_name"]).to eq(first_cust.first_name)
    expect(customer["id"]).not_to eq(second_cust.id)
    expect(customer["first_name"]).not_to eq(second_cust.first_name)
  end
  it 'finds all customers based on name query without case sensitivity' do
    first_cust = create(:customer, first_name: "bailey")
    second_cust = create(:customer, first_name: "Bailey")

    get "/api/v1/customers/find_all?first_name=#{first_cust.first_name}"

    first_response = JSON.parse(response.body)["data"][0]["attributes"]
    second_response = JSON.parse(response.body)["data"][1]["attributes"]

    expect(response).to be_successful
    expect(first_response["id"]).to eq(first_cust.id)
    expect(first_response["first_name"]).to eq(first_cust.first_name)
    expect(second_response["id"]).to eq(second_cust.id)
    expect(second_response["first_name"]).to eq(second_cust.first_name)
  end
  it 'finds all customers based on id query' do
    first_cust = create(:customer)
    second_cust = create(:customer)

    get "/api/v1/customers/find_all?id=#{first_cust.id}"
    first_response = JSON.parse(response.body)["data"][0]["attributes"]

    expect(response).to be_successful
    expect(first_response["id"]).to eq(first_cust.id)
    expect(first_response["first_name"]).to eq(first_cust.first_name)
  end
  it 'finds all customers based on created_at/updated_at query' do
    first_cust = create(:customer, created_at: '2012-03-27 14:53:58 UTC', updated_at: '2012-03-27 14:53:58 UTC')
    second_cust = create(:customer, created_at: '2012-03-27 14:53:58 UTC', updated_at: '2012-03-27 14:53:58 UTC')

    get "/api/v1/customers/find_all?created_at=#{first_cust.created_at}"
    first_response = JSON.parse(response.body)["data"][0]["attributes"]
    second_response = JSON.parse(response.body)["data"][1]["attributes"]

    expect(response).to be_successful
    expect(first_response["id"]).to eq(first_cust.id)
    expect(first_response["first_name"]).to eq(first_cust.first_name)
    expect(second_response["id"]).to eq(second_cust.id)
    expect(second_response["first_name"]).to eq(second_cust.first_name)

    get "/api/v1/customers/find_all?updated_at=#{first_cust.updated_at}"
    first_response = JSON.parse(response.body)["data"][0]["attributes"]
    second_response = JSON.parse(response.body)["data"][1]["attributes"]

    expect(response).to be_successful
    expect(first_response["id"]).to eq(first_cust.id)
    expect(first_response["first_name"]).to eq(first_cust.first_name)
    expect(second_response["id"]).to eq(second_cust.id)
    expect(second_response["first_name"]).to eq(second_cust.first_name)
  end
  it 'finds one random customer' do
    customers = create_list(:customer, 3)
    first_cust = customers[0]
    second_cust = customers[1]

    get "/api/v1/customers/random.json"
    customer = JSON.parse(response.body)

    expect(response).to be_successful
  end
  it 'displays all associated invoices' do
    cust_1 = create(:customer)
    cust_2 = create(:customer)
    merchant = create(:merchant)
    invoice_1 = create(:invoice, merchant: merchant, customer: cust_1)
    invoice_2 = create(:invoice, merchant: merchant, customer: cust_2)

    get "/api/v1/customers/#{cust_1.id}/invoices"
    invoices = JSON.parse(response.body)
    return_invoice_1 = invoices["data"][0]
    return_invoice_2 = invoices["data"][1]

    expect(response).to be_successful
    expect(invoices["data"].count).to eq(1)
    expect(return_invoice_1["attributes"]["id"]).to eq(invoice_1.id)
  end
  it 'displays all associated transactions' do
      cust_1 = create(:customer)
      cust_2 = create(:customer)
      merchant = create(:merchant)
      invoice_1 = create(:invoice, merchant: merchant, customer: cust_1)
      invoice_2 = create(:invoice, merchant: merchant, customer: cust_2)
      trans_1 = create(:transaction, invoice: invoice_1)
      trans_2 = create(:transaction, invoice: invoice_1)

      get "/api/v1/customers/#{cust_1.id}/transactions"
      transactions = JSON.parse(response.body)
      return_trans_1 = transactions["data"][0]
      return_trans_2 = transactions["data"][1]

      expect(response).to be_successful
      expect(transactions["data"].count).to eq(2)
      expect(return_trans_1["attributes"]["id"]).to eq(trans_1.id)
      expect(return_trans_2["attributes"]["id"]).to eq(trans_2.id)
    end
end
