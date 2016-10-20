class Space
  attr_accessor :length, :height, :gravity, :elements
<<<<<<< HEAD
  attr_accessor :player, :alive, :max_height, :time, :hud, :coins

  def initialize(length, height, gravity) # sets up the game
    @length = length
    @height = height
    @gravity = Vector.elements(gravity)
    @player = Element.new(gets_char, [0, 1])
    @elements = [@player]
    create_floor(@length, 0)
    stats
  end

=======
  attr_accessor :player, :alive, :max_height, :time, :hud

  def initialize(length, height, gravity) # sets up the game
    size(length, height)
    @gravity = Vector.elements(gravity)
    @player = Element.new(gets_char, [0, 1])
    @elements = [@player]
    create_floor(0, @length, 0)
    stats
  end

  def size(length, height) # sets the game boards length and height
    @length = length
    @height = height
  end

>>>>>>> 63e23774686169cf08c87ce868cfcf5d4285d6ee
  def stats # initializes stats relating to the player
    @alive = true
    @max_height = @player.xy[1]
    @time = 0
    @hud = true
<<<<<<< HEAD
    @coins = 0
=======
>>>>>>> 63e23774686169cf08c87ce868cfcf5d4285d6ee
  end

  def gets_char # sets the players printed symbol from user input
    puts 'Choose your character?'
    system('stty raw -echo')
    char = STDIN.getc
    system('stty -raw echo')
    char
  end

  def tick # drops random elements and ticks forward each element 1 unit of time
<<<<<<< HEAD
    drop_blocks(@length, @player.xy[1] + @height, [6, 9, 12])
    grab_coin
    elementer
    grab_coin
  end

  def debug
    p @player
    p @player.to_be
    p at_xy(@player.to_be)
=======
    drop_blocks(@length, @player.xy[1] + @height, [10, 30])
    elementer
>>>>>>> 63e23774686169cf08c87ce868cfcf5d4285d6ee
  end

  def elementer # ticks each element that's either a player or a falling block
    @elements.each do |element|
<<<<<<< HEAD
      next if element.kind == '='
=======
      next unless (element.kind == @player.kind) || (element.kind == 'O')
>>>>>>> 63e23774686169cf08c87ce868cfcf5d4285d6ee
      element_tick(element)
    end
  end

<<<<<<< HEAD
  # applies gravity, checks if alive or colliding, moves, and stay within bounds
  def element_tick(element)
=======
  def element_tick(element) # applies gravity, checks if alive or colliding, moves, and makes element stay within bounds
>>>>>>> 63e23774686169cf08c87ce868cfcf5d4285d6ee
    element.force(@gravity)
    check_alive
    collide(element)
    element.tick
    element.bounds(@length - 1)
  end

  def collide(elem) # stops blocks from colliding with eachother
<<<<<<< HEAD
    elem.stop('y') if at_xy(elem.to_be) && elem.speed[1].abs > 0 ||
                      at_xy(elem.to(0, -1, @length)) && elem.speed[1] < 0 ||
                      at_xy(elem.to(0, 1, @length)) && elem.speed[1] > 0 ||
                      at_xy(elem.to(-1, -1, @length)) && elem.speed == Vector[-1, -1] ||
                      at_xy(elem.to(1, -1, @length)) && elem.speed == Vector[1, -1]

    elem.stop('x') if at_xy(elem.to_be) && elem.speed[0].abs > 0 ||
                      at_xy(elem.to(1, 0, @length)) && elem.speed[0] > 0 ||
                      at_xy(elem.to(-1, 0, @length)) && elem.speed[0] < 0
=======
    elem.stop('y') if at_xy(elem.to(-1, -1)) && elem.speed == Vector[-1, -1] ||
                      at_xy(elem.to(1, -1)) && elem.speed == Vector[1, -1] ||
                      at_xy(elem.to(0, -1)) && elem.speed[1] < 0 ||
                      at_xy(elem.to(0, 1)) && elem.speed[1] > 0
    elem.stop('x') if at_xy(elem.to(1, 0)) && elem.speed[0] > 0 ||
                      at_xy(elem.to(-1, 0)) && elem.speed[0] < 0
>>>>>>> 63e23774686169cf08c87ce868cfcf5d4285d6ee
  end

  def check_alive # signals an end to the game if the player is surrounded
    @max_height = @player.xy[1] if @player.xy[1] > @max_height
    @alive = false if surrounded?
  end

  def surrounded? # returns true if player is surrounded on all sides
<<<<<<< HEAD
    at_xy(@player.to(0, 1, @length)) &&
      at_xy(@player.to(0, -1, @length)) &&
      at_xy(@player.to(-1, 0, @length)) &&
      at_xy(@player.to(1, 0, @length))
  end

  def jump? # returns true if the player is able to jump
    !at_xy(@player.to(0, 1, @length)) &&
      at_xy(@player.to(0, -1, @length)) ||
      at_xy(@player.to(1, 0, @length)) ||
      at_xy(@player.to(-1, 0, @length))
  end

  def grab_coin
    return unless at_xy(@player.to_be) && at_xy(@player.to_be).kind == '$'
    @elements.delete(at_xy(@player.to_be))
    @coins += 1
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
=======
    at_xy(@player.to(0, 1)) &&
      at_xy(@player.to(0, -1)) &&
      at_xy(@player.to(-1, 0)) &&
      at_xy(@player.to(1, 0))
  end

  def jump? # returns true if the player is able to jump
    at_xy(@player.to(0, -1)) ||
      at_xy(@player.to(1, 0)) ||
      at_xy(@player.to(-1, 0))
  end

  def at_xy(xy) # if there's an element at the given xy coordinate, the element is returned
    @elements.detect { |element| element.xy == xy }
  end

  def random_line(length, height, odds) # creates a random block if both random numbers are equal to eachother
    return unless rand(0..odds) == rand(0..odds)
    @elements << Element.new('O', [rand(length), height])
  end

  def random_blocks(length, height, odds) # creates a random 2x2 block if both random numbers are equal to eachother
    return unless rand(0..odds) == rand(0..odds)
    block = [[0, 0], [1, 0], [0, 1], [1, 1]]
    block.each do |xy|
      @elements << Element.new('O', [rand(length - 1) + xy[0], height + xy[1]])
>>>>>>> 63e23774686169cf08c87ce868cfcf5d4285d6ee
    end
  end

  def drop_blocks(length, height, odds) # drops random blocks
<<<<<<< HEAD
    random_line(length, height, odds[0], 'O')
    random_line(length, height, odds[1], '$')
    random_blocks(length, height, odds[2], 'O')
  end

  def create_floor(length, height) # creates a floor
    (0..length).each { |i| @elements << Element.new('=', [i, height]) }
=======
    random_line(length, height, odds[0])
    random_blocks(length, height, 1)
  end

  def create_floor(len, length, height) # creates a floor at y=height from x[0]=len to x[1]=length
    (len...length).each { |i| @elements << Element.new('=', [i, height]) }
>>>>>>> 63e23774686169cf08c87ce868cfcf5d4285d6ee
  end
end
