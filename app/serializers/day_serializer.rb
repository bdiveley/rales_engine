class DaySerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :best_day
end
