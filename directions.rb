module Directions
  CARDINAL_POINTS = ['N','S','E','W'].freeze

  def self.move(position, direction)
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

  def self.cardinal_text(direction)
    case direction
    when 'N' then 'north'
    when 'E' then 'east'
    when 'S' then 'south'
    when 'W' then 'west'
    end
  end
end
