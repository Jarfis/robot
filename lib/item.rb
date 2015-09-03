class Item
  attr_reader :name, :weight
  
  def initialize(the_name, the_weight)
    @name = the_name
    @weight = the_weight
  end
end
