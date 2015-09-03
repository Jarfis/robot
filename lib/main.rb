require_relative "robot"
require_relative "item"
require_relative "box_of_bolts"
require_relative "weapon"
require_relative "grenade"
require_relative "battery"

r = Robot.new
r2 = Robot.new
bob = BoxOfBolts.new
g=Grenade.new
g2 = Grenade.new
b = Battery.new
b2 = Battery.new

r.move_up
r.move_up

r.attack(r2)

r.wound(20)
r.pick_up(bob)
puts r.health

#r.pick_up(g)
#r.pick_up(g2)

#r.attack(r2)

#r.pick_up(b)
#r.pick_up(b2)

#puts
#puts r.items.inspect
#b.recharge(r)
#puts

#puts r.items.inspect

r.scan

#puts r == r2
#puts r == r
