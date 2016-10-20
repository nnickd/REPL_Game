require_relative 'element.rb'

class Player < Element
  attr_accessor :alive, :max_height, :hud, :coins
  def initialize(kind = '~', xy = [0, 0], speed = [0, 0], limit = 2)
    super(kind, xy, speed, limit)
    @alive = true
    @max_height = @xy[1]
    @hud = true
    @coins = 0
  end

  def grab_coin(elements)
    return unless at_xy(elements, to_be) && at_xy(elements, to_be).kind == '$'
    elements.delete(at_xy(elements, to_be))
    @coins += 1
  end

  def update_stats(elements, length) # signals an end to the game if the player is surrounded
    @max_height = @xy[1] if @xy[1] > @max_height
    @alive = false if surrounded?(elements, length)
  end

  def surrounded?(elements, length) # returns true if player is surrounded on all sides
    at_xy(elements, to(0, 1, length)) &&
      at_xy(elements, to(0, -1, length)) &&
      at_xy(elements, to(-1, 0, length)) &&
      at_xy(elements, to(1, 0, length))
  end

  def jump?(elements, length) # returns true if the player is able to jump
    !at_xy(elements, to(0, 1, length)) &&
      at_xy(elements, to(0, -1, length)) ||
      at_xy(elements, to(1, 0, length)) ||
      at_xy(elements, to(-1, 0, length))
  end

end
