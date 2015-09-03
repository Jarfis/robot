class Battery < Item
  def initialize
    super("Battery", 25)
  end

  def recharge(target)
    target.heal_shields(50)
    target.items.delete(self)
#    target.items.each.with_index do |v,i|
      
#    end
  end
end
