class Weapon < Item
  attr_reader :damage, :range
  def initialize(the_name, the_weight, the_dam)
    super(the_name, the_weight)
    @damage = the_dam
    @range = 1
  end

  def hit(target)
    target.wound(@damage)
  end
end
