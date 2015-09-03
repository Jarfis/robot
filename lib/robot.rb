require_relative "custom_exceptions"
class Robot
  @@the_robots = []
  
  attr_reader :position, :items, :health, :shields
  attr_accessor :equipped_weapon

  MAX_HEALTH = 100
  MAX_WEIGHT = 250
  MAX_SHIELDS = 50
  BASIC_DMG = 5
  def initialize
    @position = [0,0]
    @items = []
    @health = MAX_HEALTH
    @shields = MAX_SHIELDS

    @@the_robots.push(self)
  end

  def self.the_robots
    @@the_robots
  end

  def self.in_position(x,y)
    r_at=[]
    @@the_robots.each do |v|
      if v.position == [x,y]
        r_at.push(v)
      end
    end
    r_at
  end

  def scan
    found = []

    Robot.the_robots.each do |i|
      if (self.position[0]-i.position[0]).between?(-1,1) && (self.position[1] - i.position[1]).between?(-1, 1)
        unless i == self
          found.push(i)
        end
      end
    end
    found
#    [@position[0]-1..@position[0]+1].each do |i|
#      [@position[1]-1..@position[1]+1].each do |k|
#        puts "#{i}, #{k}"  #the fuck is going on here, outputs [-1..1],[1..3]
#      end
#    end
  end

  def move_left
    @position[0]-=1
  end

  def move_right
    @position[0]+=1
  end

  def move_up
    @position[1]+=1
  end

  def move_down
    @position[1]-=1
  end

  def pick_up(the_item)
    unless items_weight+the_item.weight>MAX_WEIGHT
      if the_item.is_a?(Weapon) && @equipped_weapon == nil
        @equipped_weapon = the_item
        @items.push(the_item)
      elsif the_item.is_a?(BoxOfBolts) && MAX_HEALTH >= self.health + the_item.heal_amount
        the_item.feed(self)
      else
        @items.push(the_item)
      end
    end
  end

  def items_weight
    weight = 0
    @items.each do |i|
      weight += i.weight
    end
    weight
  end

  def wound(dam)
    if @shields > 0
      unless @shields -dam <0
        @shields -= dam
      else
        overrun = dam-@shields
        @shields = 0
        wound(overrun)
      end
    else
      unless @health -dam <0
        @health -= dam
      else
        @health = 0
      end
    end
  end

  def pierce(dam)
    unless @health -dam <0
      @health -= dam
    else
      @health = 0
    end
  end

  def heal(the_heal)
    unless @health + the_heal > MAX_HEALTH
      @health += the_heal
    else
      @health = MAX_HEALTH
    end
  end

  def heal!(the_heal)
    if @health == 0
      raise AlreadyDeadError
    else
      heal(the_heal)
    end
  end

  def heal_shields(the_heal)
      unless @shields + the_heal > MAX_SHIELDS
      self.shields += the_heal
    else
      self.shields = MAX_SHIELDS
    end
  end

  def attack(target)
    if target.position[0].between?(@position[0]-1, @position[0]+1) && target.position[1].between?(@position[1]-1, @position[1]+1)
      unless @equipped_weapon == nil
        @equipped_weapon.hit(target)
      else
        target.wound(BASIC_DMG)
      end
    elsif target.position[0].between?(@position[0]-2, @position[0]+2) && target.position[1].between?(@position[1]-2, @position[1]+2) && @equipped_weapon.is_a?(Grenade)
      @equipped_weapon.hit(target)
      @items.each.with_index do |v,i|
        if v.is_a?(Grenade)
          @items.delete_at(i)
          break
        end
      end
      @equipped_weapon = nil
    end
  end

  def attack!(target)
    if target.is_a? Robot
      attack(target)
    else
      raise InvalidTargetError
    end
  end
end
