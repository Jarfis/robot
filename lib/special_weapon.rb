class SpecialWeapon < Weapon
  def initialize
    super("Special Weapon", 5, 30)
  end

  def explode(origin)
    origin.scan.each do |r|
      r.pierce(@damage)
    end
  end
end
