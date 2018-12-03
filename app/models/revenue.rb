class Revenue
  attr_reader :id, :revenue, :total_revenue

  def initialize(revenue)
    @id = 1
    @total_revenue = revenue
    @revenue = revenue
  end

end
