class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :status

end
