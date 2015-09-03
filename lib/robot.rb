require_relative "custom_exceptions"
class Robot
  attr_reader :position, :items, :health
  attr_accessor :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
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
    unless items_weight+the_item.weight>250
      if the_item.is_a?(Weapon) && @equipped_weapon == nil
        @equipped_weapon = the_item
        @items.push(the_item)
      elsif the_item.is_a?(BoxOfBolts) && 100 >= @health + the_item.heal_amount
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
    unless @health -dam <0
      @health -= dam
    else
      @health = 0
    end
  end

  def heal(the_heal)
    unless @health + the_heal > 100
      @health += the_heal
    else
      @health = 100
    end
  end

  def heal!(the_heal)
    puts "XXXXXXXXXXX"
    puts @health
    puts "XXXXXXXXXXX"
    if @health == 0
      raise AlreadyDeadError
    else
      heal(the_heal)
    end
  end

  def attack(target)
    if target.position[0].between?(@position[0]-1, @position[0]+1) && target.position[1].between?(@position[1]-1, @position[1]+1)
      unless @equipped_weapon == nil
        @equipped_weapon.hit(target)
      else
        target.wound(5)
      end
    elsif target.position[0].between?(@position[0]-2, @position[0]+2) && target.position[1].between?(@position[1]-2, @position[1]+2) && @equipped_weapon.is_a?(Grenade)
      @equipped_weapon.hit(target)
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
