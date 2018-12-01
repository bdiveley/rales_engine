class Invoice_ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :quantity

  attribute :unit_price do |object|
    object.unit_price / 100.00
  end

end
