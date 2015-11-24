require './encounter'
require './dungeon'
require './quest'
require './introduction'

CARDINAL_DIRECTIONS = ['N','S','E','W'].freeze

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

def flip_direction(direction)
  case direction
  when 'N' then 'S'
  when 'S' then 'N'
  when 'E' then 'W'
  when 'W' then 'E'
  end
end

def cardinal_text(direction)
  case direction
  when 'N' then 'north'
  when 'E' then 'east'
  when 'S' then 'south'
  when 'W' then 'west'
  end
end

DungeonGenerator = Dungeon.new

class Chamber
  attr_accessor :exits

  def initialize(position, exits, previous)
    @position = position
    @exits = exits
    @previous = previous
  end

  def position
    @position.to_s
  end

  def generate_text
    DungeonGenerator.generate
  end

  def generate_exits
    if @exits.empty?
      ['There is no way forward', 'You have come to a dead end.'].sample
    elsif @exits.count == 1
      "There is a passage leading #{cardinal_text(@exits.first)}."
    else
      "There are passages to the #{@exits.map { |d| cardinal_text(d) }.join(' and ')}."
    end
  end
end

class Area
  def initialize(size: 500)
    @size = size
    @start = [0,0]
    @chambers = {}
  end

  def generate
    add_chamber(@start)
    @chambers
  end

  def place_exits(position, from_direction)
    exit_directions = CARDINAL_DIRECTIONS.reject do |direction|
      direction == from_direction
    end.reject do |direction|
      @chambers.key?(move_position(position, direction))
    end

    exit_directions.sample(rand(1..3))
  end

  def add_chamber(position, from_direction=nil, previous=nil)
    if @chambers.count < @size
      exits = place_exits(position, from_direction)
    else
      exits = []
    end

    @chambers[position] = unless from_direction.nil?
      Chamber.new(position, exits | [flip_direction(from_direction)], previous)
    else
      Chamber.new(position, exits, previous)
    end

    exits.each do |direction|
      add_chamber(move_position(position, direction), direction, @chambers[position])
    end
  end
end

area = Area.new
chambers = area.generate

max_x, _ = chambers.keys.max_by { |(x, y)| x }
_, max_y = chambers.keys.max_by { |(x, y)| y }
min_x, _ = chambers.keys.min_by { |(x, y)| x }
_, min_y = chambers.keys.min_by { |(x, y)| y }

map = []
wall = ' '.freeze
room = '#'.freeze
entrance = '@'.freeze
end_tile = '%'.freeze
found_start = false
found_end = false

if (max_x - min_x) > (max_y - min_y)
  check_start = -> (x,y) { x == min_x }
  check_end = -> (x,y) { x == max_x }
else
  check_start = -> (x,y) { y == min_y }
  check_end = -> (x,y) { y == max_y }
end

min_x.upto(max_x) do |x|
  row = []
  min_y.upto(max_y) do |y|
    chamber = chambers[[x,y]]
    if chamber.nil?
      row << {tile: wall, chamber: chamber}
    elsif chamber.position == '[0,0]'
      row << {tile: entrance, chamber: chamber}
    elsif !found_start && check_start.call(x,y)
      row << {tile: entrance, chamber: chamber}
      found_start = true
    elsif !found_end && check_end.call(x,y)
      row << {tile: end_tile, chamber: chamber}
      found_end = true
    else
      row << {tile: room, chamber: chamber}
    end
  end
  map << row
end

require 'rasem'

File.open("map.svg", "w") do |f|
  Rasem::SVGImage.new(800, 800, f) do |f|
    map.each_with_index do |row, i|
      row.each_with_index do |col, j|
        if col[:tile] == room
          exits = col[:chamber].exits
          #rectangle(i*10, j*10, 10, 10, :stroke_width=>1, :fill=> 'green')
          line(i*10, j*10, i*10+10, j*10) unless exits.include?('N')
          line(i*10, j*10, i*10, j*10+10) unless exits.include?('W')
          line(i*10+10, j*10, i*10+10, j*10+10) unless exits.include?('E')
          line(i*10, j*10+10, i*10+10, j*10+10) unless exits.include?('S')
        elsif col[:tile] == entrance
          exits = col[:chamber].exits
          rectangle(i*10, j*10, 10, 10, :stroke_width=>1, :fill=> 'cyan')
          line(i*10, j*10, i*10+10, j*10) unless exits.include?('N')
          line(i*10, j*10, i*10, j*10+10) unless exits.include?('W')
          line(i*10+10, j*10, i*10+10, j*10+10) unless exits.include?('E')
          line(i*10, j*10+10, i*10+10, j*10+10) unless exits.include?('S')
        elsif col[:tile] == end_tile
          exits = col[:chamber].exits
          rectangle(i*10, j*10, 10, 10, :stroke_width=>1, :fill=> 'orange')
          line(i*10, j*10, i*10+10, j*10) unless exits.include?('N')
          line(i*10, j*10, i*10, j*10+10) unless exits.include?('W')
          line(i*10+10, j*10, i*10+10, j*10+10) unless exits.include?('E')
          line(i*10, j*10+10, i*10+10, j*10+10) unless exits.include?('S')
        end
      end
    end
  end
end

intro = Introduction.new

File.open("map.html", "w") do |f|
  f.puts '<meta charset="utf-8">'
  f.puts '<body>'
  f.puts '<img src="map.svg">'

  f.puts '<h3>Introduction</h3>'
  f.puts "<p>#{intro.generate}</p>"

  chambers.each_with_index do |(position, chamber), i|
    f.puts "<h3>§ #{i+1}</h3>"
    f.puts "<p>#{chamber.generate_text}</p>"
    f.puts "<p>#{chamber.generate_exits}</p>"
  end
  f.puts '</body>'
end
