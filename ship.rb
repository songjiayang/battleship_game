class Ship
  attr_writer :alive

  def initialize
    @alive = true
  end

  def alive?
    @alive
  end
end
