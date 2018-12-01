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
  xit 'finds one specific customer based on id query' do
    customers = create_list(:merchant, 3)
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
end
