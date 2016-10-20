require_relative 'space.rb'
require_relative 'element.rb'

class Render
  attr_accessor :space

  def initialize(space) # takes the space
    @space = space
    @time = 0
  end

  def render(length, height) # draws the game within the given coordinates
    view = []
    (height[0]..height[1]).each do |y|
      line = [' '] * length
      y_list = @space.elements.select { |element| element.xy[1] == y }
      y_list.each { |element| line[element.xy[0]] = element.kind }
      view << line
    end
    show(view.reverse, height[1] - height[0])
    @time += 1
  end

  def show(view, height) # puts the updated game state
    (0..height).each do |y|
      puts view[y].join(' ')
    end
    hud
    # @space.debug
  end

  def hud # puts stats, controls, and how to quit below game
    return unless @space.player.hud
    stats = "max height: #{@space.player.max_height}  |  coins: #{@space.player.coins}  |  "
    vectors = "time: #{@time}  |  xy: #{@space.player.xy.to_a}  |  speed: #{@space.player.speed.to_a}"
    commands = "a = move left  |  w = jump  |  d = move right  |  q = quit game  |  h = toggle hud"
    puts '-' * (stats.length + vectors.length)
    puts stats << vectors
    puts '-' * commands.length
    puts commands
    puts '-' * commands.length
  end

  def user_input # takes single character user input and returns as command
    system('stty raw -echo')
    command = STDIN.getc
    system('stty -raw echo')
    system('clear')
    command
  end

  # while the player is still alive, tick space forward, draw game that follows player, and process user input
  def game_loop
    while @space.player.alive == true
      @space.tick
      player_height = @space.player.xy[1] - 5
      render(@space.length, [player_height, @space.height + player_height])
      input = user_input
      input == 'q' ? break : @space.player.process_input(@space, input)
    end
    you_lose
  end

  def you_lose # puts end of game stuff
    puts 'YOU DIED!'
    puts "max height: #{@space.player.max_height}"
    puts "time: #{@time}"
  end
end

puts 'length?'
length = gets.chomp.to_i
length = length > 59 ? 59 : length
length = length < 7 ? 7 : length

space = Space.new(length, 42, [0, -1])
view = Render.new(space)
view.game_loop
