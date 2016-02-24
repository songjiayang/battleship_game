class Grid
  attr_accessor :ship

  def hit
    @hit = true
    self.ship.alive = false if self.ship
  end

  def hit?
    @hit == true
  end

  def to_s
    return ' ' unless hit?
    return 'X' if self.ship
    '/'
  end
end
