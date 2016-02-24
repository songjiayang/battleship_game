require './player'

class Game
  def play
    @computer = Player.new('Computer')
    @you = Player.new('You')
    until winner
      refresh_screen
      square = gets.chomp
      @you.hit(@computer, square.split(',').map{|i| i.to_i-1})
      @computer.random_hit(@you)
    end
    puts "#{winner.name} is the winner!"
  end

  def winner
    return @you unless @computer.alive?
    return @computer unless @you.alive?
  end

  def refresh_screen
    @you.status
    puts
    @computer.status
    print "Please select a square (Such as 3, 5) to open fire!"
  end
end

Game.new.play
