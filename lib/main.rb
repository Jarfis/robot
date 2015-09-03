require_relative "robot"
require_relative "item"
require_relative "box_of_bolts"
require_relative "weapon"

r = Robot.new
r2 = Robot.new
bob = BoxOfBolts.new

r.move_up
r.move_up

r.attack(r2)

r.wound(20)
r.pick_up(bob)
puts r.health
