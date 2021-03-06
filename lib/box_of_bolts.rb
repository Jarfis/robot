class BoxOfBolts < Item
  attr_reader :heal_amount
  def initialize
    super("Box of bolts",25)
    @heal_amount = 20
  end

  def feed(target)
    target.heal(@heal_amount)
    target.items.delete(self)
  end
end
