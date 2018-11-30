require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end
  describe 'relationships' do
    it { should belong_to :merchant}
    it { should have_many :invoice_items}
    it { should have_many(:invoices).through(:invoice_items)}
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
    it 'returns top items by total revenue' do
      item = Item.top_items_by_total_revenue(1)
      expect(item.first.name).to eq(@item_2.name)
      expect(item.first.id).to eq(@item_2.id)

      item = Item.top_items_by_total_revenue(2)
      expect(item.length).to eq(2)
    end
    it 'return top items by items sold' do
      item = Item.top_items_by_items_sold(1)
      expect(item.first.name).to eq(@item_1.name)
      expect(item.first.id).to eq(@item_1.id)

      item = Item.top_items_by_items_sold(2)
      expect(item.length).to eq(2)
    end
  end
end
