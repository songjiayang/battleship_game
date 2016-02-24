require './ship'

class ShipTeam
  attr_reader :ships

  def initialize(name, ship_number)
    @name = name
    @ships = Array.new(ship_number) { Ship.new }
    @order = team_order
  end

  def lateral?
    @order == 'lateral'
  end

  def portrait?
    @order == 'portrait'
  end

  def to_s
    "#{@name}: #{status} "
  end

  def alive?
    @ships.any? { |ship| ship.alive? }
  end

  private
    def status
      alive? ? 'Alive' : 'Suck'
    end

    def team_order
      %w(lateral portrait).sample
    end
end
