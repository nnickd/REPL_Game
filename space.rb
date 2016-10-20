require_relative 'player.rb'

class Space
  attr_accessor :length, :height, :gravity, :elements, :player, :hud

  def initialize(length, height, gravity) # sets up the game
    @length = length
    @height = height
    @gravity = Vector.elements(gravity)
    @player = Player.new(gets_char, [0, 1])
    @elements = [@player]
    @hud = true
    create_floor(@length, 0)
  end

  def gets_char # sets the players printed symbol from user input
    puts 'Choose your character?'
    system('stty raw -echo')
    char = STDIN.getc
    system('stty -raw echo')
    char
  end

  def debug
    p @player
    p at_xy(@player.to_be)
  end

  def tick # drops random elements and ticks forward each element 1 unit of time
    drop_blocks(@length, @player.xy[1] + @height, [6, 9, 12])
    @player.grab_coin(@elements)
    elementer
    # @player.grab_coin(@elements)
  end

  def elementer # ticks each element that's either a player or a falling block
    @player.update_stats(@elements, @length)
    @elements.each do |element|
      next if element.kind == '='
      element_tick(element)
    end
  end

  # applies gravity, checks if alive or colliding, moves, and stay within bounds
  def element_tick(element)
    element.force(@gravity)
    collide(element)
    element.tick
    element.bounds(@length - 1)
  end

  def collide(elem) # stops blocks from colliding with eachother
    elem.stop('y') if at_xy(elem.to_be) && elem.speed[1].abs > 0 ||
                      at_xy(elem.to(0, -1, @length)) && elem.speed[1] < 0 ||
                      at_xy(elem.to(0, 1, @length)) && elem.speed[1] > 0 ||
                      at_xy(elem.to(-1, -1, @length)) && elem.speed == Vector[-1, -1] ||
                      at_xy(elem.to(1, -1, @length)) && elem.speed == Vector[1, -1]

    elem.stop('x') if at_xy(elem.to_be) && elem.speed[0].abs > 0 ||
                      at_xy(elem.to(1, 0, @length)) && elem.speed[0] > 0 ||
                      at_xy(elem.to(-1, 0, @length)) && elem.speed[0] < 0
  end

  # if there's an element at the given xy coordinate, the element is returned
  def at_xy(xy)
    @elements.detect { |element| element.xy == xy }
  end

  # creates a random block if both random numbers are equal to eachother
  def random_line(length, height, odds, kind)
    return unless rand(0..odds) == rand(0..odds)
    @elements << Element.new(kind, [rand(length), height])
  end

  # creates a random 2x2 block if both random numbers are equal to eachother
  def random_blocks(length, height, odds, kind)
    return unless rand(0..odds) == rand(0..odds)
    block = [[0, 0], [1, 0], [0, 1], [1, 1]]
    length = rand(length - 1)
    block.each do |xy|
      @elements << Element.new(kind, [length + xy[0], height + xy[1]], [0, 0], 1)
    end
  end

  def drop_blocks(length, height, odds) # drops random blocks
    random_line(length, height, odds[0], 'O')
    random_line(length, height, odds[1], '$')
    random_blocks(length, height, odds[2], 'O')
  end

  def create_floor(length, height) # creates a floor
    (0..length).each { |i| @elements << Element.new('=', [i, height]) }
  end
end
