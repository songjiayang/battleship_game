require './grid'
require './ship_team'

class Board
  def initialize
    init_grids
    init_ship_teams
    assign_ships
  end

  def hit(square)
    @grids[square[0]][square[1]].hit
  end

  def random_hit
    can_hit_squares = []
    @grids.each_with_index do |group, row_index|
      group.each_with_index do |grid, col_index|
        can_hit_squares.push [row_index, col_index] unless @grids[row_index][col_index].hit?
      end
    end
    hit(can_hit_squares.sample)
  end

  def status
    puts draw_x_index
    puts draw_border_line
    @grids.each_with_index do |group, index|
      puts draw_content_line(index+1, group)
      puts draw_border_line
    end
    puts
    puts @ship_teams.map {|ship_team| ship_team.to_s }.join('    ')
  end

  def alive?
    @ship_teams.any? { |ship_team| ship_team.alive? }
  end

  private

  def draw_x_index
    x_index = '    '
    @grids.length.times { |i|  x_index +="#{i+1}   "}
    x_index
  end

  def draw_border_line
    line = '  +'
    @grids.length.times { line +="---+" }
    line
  end

  def draw_content_line(index, group)
    line = "#{index} |"
    group.each { |cell| line +=" #{cell.to_s} |" }
    line
  end

  def init_grids
    @grids = Array.new(5) { Array.new(5) { Grid.new } }
  end

  def init_ship_teams
    @ship_teams = []
    @ship_teams.push ShipTeam.new('Destroyer', 1)
    @ship_teams.push ShipTeam.new('Cruiser', 2)
    @ship_teams.push ShipTeam.new('Battleship', 3)
  end

  def assign_ships
    @ship_teams.each do |ship_team|
      assigned = false
      until assigned
        start_grid = ship_team_start_grid(ship_team)
        possible = check_start_grid(start_grid, ship_team)
        if possible
          assign_team_ships(start_grid, ship_team)
          assigned = true
        end
      end
    end
  end

  def ship_team_start_grid(ship_team)
    max_length = @grids.length - ship_team.ships.length + 1
    square = [rand(max_length), rand(@grids.length)]
    square.reverse! unless ship_team.lateral?
    square
  end

  def check_start_grid(start_grid, ship_team)
    possible = true
    ship_team.ships.each_with_index do |ship, index|
      if ship_team.lateral?
        cell = @grids[start_grid[0]+index][start_grid[1]]
      else
        cell = @grids[start_grid[0]][start_grid[1]+index]
      end
      unless cell.ship.nil?
        possible = false
        break
      end
    end
    possible
  end

  def assign_team_ships(start_grid, ship_team)
    ship_team.ships.each_with_index do |ship, index|
      if ship_team.lateral?
        cell = @grids[start_grid[0] + index][start_grid[1]]
      else
        cell = @grids[start_grid[0]][start_grid[1]+index]
      end
      cell.ship = ship
    end
  end
end
