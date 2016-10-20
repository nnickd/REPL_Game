require_relative 'space.rb'
require_relative 'element.rb'

class Render
  attr_accessor :space

  def initialize(space) # takes the space
    @space = space
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
    @space.time += 1
  end

  def show(view, height) # puts the updated game state
    (0..height).each do |y|
      puts view[y].join(' ')
    end
    hud
<<<<<<< HEAD
    @space.debug
=======
>>>>>>> 63e23774686169cf08c87ce868cfcf5d4285d6ee
  end

  def hud # puts stats, controls, and how to quit below game
    return unless @space.hud
<<<<<<< HEAD
    first = "max height: #{@space.max_height}  |  coins: #{@space.coins}  |  time: #{@space.time}"
=======
    first = "max height: #{@space.max_height}  |  time: #{@space.time}"
>>>>>>> 63e23774686169cf08c87ce868cfcf5d4285d6ee
    second = "'a' = move left  |  'w' = jump  |  'd' = move right"
    third = "'q' = quit game  |  'h' = toggle hud"
    puts '-' * first.length
    puts first
    puts '-' * first.length
    puts '-' * second.length
    puts second
    puts '-' * second.length
    puts '-' * third.length
    puts third
    puts '-' * third.length
  end

  def user_input # takes single character user input and returns as command
    system('stty raw -echo')
    command = STDIN.getc
    system('stty -raw echo')
    system('clear')
    command
  end

<<<<<<< HEAD
  # processess user input for moving player, jumping and toggling the hud
  def process_input(command)
    case command.downcase
=======
  def process_input(command) # processess user input for moving player, jumping and toggling the hud
    case command
>>>>>>> 63e23774686169cf08c87ce868cfcf5d4285d6ee
    when 'a' # left
      @space.player.force(Vector[-1, 0])
    when 'd' # jump
      @space.player.force(Vector[1, 0])
    when 'w' # up
      @space.player.force(Vector[0, 4]) if @space.jump?
<<<<<<< HEAD
    when 's' # down
      @space.player.force(Vector[0, -1])
=======
>>>>>>> 63e23774686169cf08c87ce868cfcf5d4285d6ee
    when 'h' # hud
      @space.hud = !@space.hud
    end
  end

<<<<<<< HEAD
  # while the player is still alive, tick space forward, draw game that follows player, and process user input
  def game_loop
=======
  def game_loop # while the player is still alive, tick space forward, draw game that follows player, and process user input
>>>>>>> 63e23774686169cf08c87ce868cfcf5d4285d6ee
    while @space.alive == true
      @space.tick
      render(@space.length, [@space.player.xy[1] - 5, @space.player.xy[1] + @space.height - 5])
      input = user_input
<<<<<<< HEAD
      input == 'q' ? break : process_input(input)
=======
      break if input == 'q'
      process_input(input)
>>>>>>> 63e23774686169cf08c87ce868cfcf5d4285d6ee
    end
    you_lose
  end

  def you_lose # puts end of game stuff
    puts 'YOU DIED!'
    puts "max height: #{@space.max_height}"
    puts "time: #{@space.time}"
  end
end

<<<<<<< HEAD
puts 'length?'
length = gets.chomp.to_i
space = Space.new(length, 64, [0, -1])
=======
space = Space.new(16, 64, [0, -1])
>>>>>>> 63e23774686169cf08c87ce868cfcf5d4285d6ee
view = Render.new(space)
view.game_loop
