require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end
  describe 'relationships' do
    it { should have_many :invoices}
  end
  describe 'class methods' do
    before(:each) do
      @merch_1 = create(:merchant)
      @merch_2 = create(:merchant)
      @cust_1 = create(:customer)
      @cust_2 = create(:customer)

      @item_1 = create(:item, merchant: @merch_1)
      @item_2 = create(:item, merchant: @merch_2)

      @inv_1 = create(:invoice, merchant: @merch_1, customer: @cust_1)
      @inv_2 = create(:invoice, merchant: @merch_1, customer: @cust_1)
      @inv_3 = create(:invoice, merchant: @merch_2, customer: @cust_2)
      @inv_4 = create(:invoice, merchant: @merch_2, customer: @cust_2)

      create(:invoice_item, quantity: 20, invoice: @inv_1, item: @item_1)
      create(:invoice_item, quantity: 10, unit_price: 3, invoice: @inv_2, item: @item_1)
      create(:invoice_item, quantity: 11, invoice: @inv_3, item: @item_2)
      create(:invoice_item, quantity: 11, invoice: @inv_4, item: @item_2)


      create(:transaction, invoice: @inv_1)
      create(:transaction, invoice: @inv_2)
      create(:transaction, result: 'failed', invoice: @inv_3)
      create(:transaction, invoice: @inv_4)
    end
    it 'returns favorite customer' do
      customer = Customer.favorite_customer(@merch_1.id)

      expect(customer.first.first_name).to eq(@cust_1.first_name)
      expect(customer.first.id).to eq(@cust_1.id)
    end
  end
end
