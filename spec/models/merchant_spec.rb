require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end
  describe 'relationships' do
    it { should have_many :invoices}
    it { should have_many :items}
  end
  describe 'class methods' do
    before(:each) do
      @merch_1 = create(:merchant)
      @merch_2 = create(:merchant)
      @cust_1 = create(:customer)

      @item_1 = create(:item, merchant: @merch_1)
      @item_2 = create(:item, merchant: @merch_2)

      @inv_1 = create(:invoice, merchant: @merch_1, customer: @cust_1)
      @inv_2 = create(:invoice, merchant: @merch_2, customer: @cust_1)
      @inv_3 = create(:invoice, merchant: @merch_2, customer: @cust_1)

      create(:invoice_item, quantity: 20, invoice: @inv_1, item: @item_1)
      create(:invoice_item, quantity: 10, unit_price: 3, invoice: @inv_2, item: @item_2)
      create(:invoice_item, quantity: 11, invoice: @inv_3, item: @item_2)

      create(:transaction, invoice: @inv_1)
      create(:transaction, invoice: @inv_2)
      create(:transaction, result: 'failed', invoice: @inv_3)
    end
    it 'returns top merchants by items solds' do
      merchant = Merchant.top_merchants_by_items_sold(1)

      expect(merchant.first.name).to eq(@merch_1.name)
      expect(merchant.first.id).to eq(@merch_1.id)
    end
    it 'returns top merchants by total revenue' do
      merchant = Merchant.top_merchants_by_total_revenue(1)

      expect(merchant.first.name).to eq(@merch_2.name)
      expect(merchant.first.id).to eq(@merch_2.id)
    end
    it 'returns favorite_merchant' do
      merchant = Merchant.favorite_merchant(@cust_1.id)

      expect(merchant.first.name).to eq(@merch_1.name)
      expect(merchant.first.id).to eq(@merch_1.id)
    end
  end
end
