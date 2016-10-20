require 'matrix'

class Element
  attr_accessor :kind, :xy, :speed, :limit

  def initialize(kind = '~', xy = [0, 0], speed = [0, 0], limit = 2) # creates element
    @kind = kind
    @xy = Vector.elements(xy)
    @speed = Vector.elements(speed)
    @limit = limit
  end

  # moves forward 1 unit of time and makes sure speed doesnt go over the limit
  def tick
    @speed = @speed.normalize * @limit if @speed.magnitude > @limit
    @speed = Vector[@speed[0].round(0), @speed[1].round(0)]
    @xy += @speed
  end

  def force(power) # adds a force vector to speed
    @speed += power
  end

  def force_other(other) # add speed to other elements speed
    other.speed += @speed
  end

  def stop(axis) # sets speed[axis] to 0
    case axis
    when 'x' then @speed = Vector[0, @speed[1]]
    when 'y' then @speed = Vector[@speed[0], 0]
    end
  end

  # wraps player from left to right makes sure not to fall through ground
  def bounds(length)
    if @xy[0] < 0
      @xy = Vector[length, @xy[1]]
    elsif @xy[0] > length
      @xy = Vector[0, @xy[1]]
    elsif @xy[1] < 1
      @xy = Vector[@xy[0], 1]
    end
  end

  def to(x, y, length) # gets an element at a given position relative to calling element
    bound_check = Vector[@xy[0] + x, @xy[1] + y]
    if bound_check[0] < 0
      Vector[length, bound_check[1]]
    elsif bound_check[0] > length - 1
      Vector[0, bound_check[1]]
    else
      bound_check
    end
  end

  def to_be # returns where the element will be next tick
    @xy + @speed
  end

  def collide_next_tick?(other)
    to_be == other.to_be
  end

  def distances(elements)
    dists = {}
    elements.each { |element| dists[element] = (element.speed - @speed).magnitude }
    dists
  end

  def within(elements, distance)
    distance_hash(elements).select { |_elem, dist| dist < distance }
  end
end
