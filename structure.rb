
CARDINAL_DIRECTIONS = ['N','S','E','W'].freeze

def available_directions(position)
  out_of_bounds = []
  out_of_bounds << 'N' if position.first == 0
  out_of_bounds << 'W' if position.last == 0
  CARDINAL_DIRECTIONS.reject { |d| !out_of_bounds.include?(d) }
end

def exit_directions(entrances=[])
  CARDINAL_DIRECTIONS.reject { |d| entrances.include?(d) }.sample(rand(1..(3-entrances.length)))
end

class Chamber
  def initialize
    @exits = {}
  end

  def exit_directions
    @exits.keys
  end

  def exits
    @exits.values
  end
end

class Area
  def initialize
    @size = rand(40..60)
    @start = [0,0]
  end

  def generate
    directions = exit_directions(available_directions(@start))
    puts directions
  end
end

area = Area.new
area.generate
