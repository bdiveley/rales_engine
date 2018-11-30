require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of :status }
  end
  describe 'relationships' do
    it { should belong_to :customer}
    it { should belong_to :merchant}
    it { should have_many :invoice_items}
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many :transactions}
  end
  describe 'class methods' do
    before(:each) do
      @merch_1 = create(:merchant)
      @merch_2 = create(:merchant)
      @cust_1 = create(:customer)

      @item_1 = create(:item, merchant: @merch_1)
      @item_2 = create(:item, merchant: @merch_2)

      @inv_1 = create(:invoice, merchant: @merch_1, customer: @cust_1, created_at: '2012-03-27 14:53:58 UTC')
      @inv_2 = create(:invoice, merchant: @merch_2, customer: @cust_1, created_at: '2012-03-28 14:53:58 UTC')
      @inv_3 = create(:invoice, merchant: @merch_2, customer: @cust_1, created_at: '2012-03-29 14:53:58 UTC')

      create(:invoice_item, quantity: 20, invoice: @inv_1, item: @item_1)
      create(:invoice_item, quantity: 10, unit_price: 3, invoice: @inv_2, item: @item_2)
      create(:invoice_item, quantity: 11, invoice: @inv_3, item: @item_2)

      create(:transaction, invoice: @inv_1)
      create(:transaction, invoice: @inv_2)
      create(:transaction, result: 'failed', invoice: @inv_3)
    end
    it 'it returns date with most sales by item' do
      date = Invoice.best_day(@item_1.id).first.created_at

      expect(date).to eq("Tue, 27 Mar 2012 14:53:58 UTC +00:00")
    end
    it 'it returns total revenue for specific merchant' do
      revenue = Invoice.total_revenue_by_merchant(@merch_1.id)

      expect(revenue).to eq(20)
    end
    it 'it returns total revenue for specific date for all merchants' do
      revenue = Invoice.total_revenue_by_date('2012-03-28')

      expect(revenue).to eq(30)
    end
    it 'it returns total revenue for specific merchant for specific date' do
      revenue = Invoice.total_revenue_per_merchant_by_date(@merch_1.id, '2012-03-27')

      expect(revenue).to eq(20)
    end
  end
end
