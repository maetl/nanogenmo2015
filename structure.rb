
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

def move_position(position, direction)
  case direction
  when 'N' then [position.first, position.last-1]
  when 'NE' then [position.first+1, position.last-1]
  when 'E' then [position.first+1, position.last]
  when 'SE' then [position.first+1, position.last+1]
  when 'S' then [position.first, position.last+1]
  when 'SW' then [position.first-1, position.last+1]
  when 'W' then [position.first-1, position.last]
  when 'NW' then [position.first-1, position.last-1]
  end
end

class Chamber
  def initialize(position, exits)
    @position = position
    @exits = exits
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
    @chambers = {}
  end

  def generate
    add_chamber(@start)
    @chambers
  end

  def add_chamber(position)
    return if @chambers.count >= @size
    exits = exit_directions(available_directions(position))
    @chambers[position] = Chamber.new(position, exits)
    exits.each do |direction|
      #add_chamber(move_position(position, direction))
    end
  end
end

area = Area.new
p area.generate
