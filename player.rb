require './board'

class Player
  attr_reader :board, :name

  def initialize(name)
    @name = name
    @board = Board.new
  end

  def hit(enemy, position)
    enemy.board.hit(position)
  end

  def random_hit(enemy)
    enemy.board.random_hit
  end

  def status
    puts "#{@name}'s Board:'"
    board.status
  end

  def alive?
    self.board.alive?
  end
end
