require './encounter'
require './quest'
require './introduction'
require './chamber'
require './labyrinth'


area = Area.new
area.generate
area.dump_descriptions
#area.dump_map

# p labyrinth[x, y]
#
# RecursiveBacktracker.on(labyrinth, labyrinth[x, y]).each_cell do |cell|
#   #p cell
# end

exit

chambers = area.get_placeholder_cells

map = []
wall = ' '.freeze
room = '#'.freeze
entrance = '@'.freeze
end_tile = '%'.freeze
found_start = false
found_end = false

min_x = area.min_x
min_y = area.min_y
max_x = area.max_x
max_y = area.max_y

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
          exits = col[:chamber].next_spaces
          rectangle(i*10, j*10, 10, 10, :stroke_width=>1, :fill=> 'green')
          # line(i*10, j*10, i*10+10, j*10) unless exits.include?('N')
          # line(i*10, j*10, i*10, j*10+10) unless exits.include?('W')
          # line(i*10+10, j*10, i*10+10, j*10+10) unless exits.include?('E')
          # line(i*10, j*10+10, i*10+10, j*10+10) unless exits.include?('S')
        elsif col[:tile] == entrance
          exits = col[:chamber].next_spaces
          rectangle(i*10, j*10, 10, 10, :stroke_width=>1, :fill=> 'cyan')
          # line(i*10, j*10, i*10+10, j*10) unless exits.include?('N')
          # line(i*10, j*10, i*10, j*10+10) unless exits.include?('W')
          # line(i*10+10, j*10, i*10+10, j*10+10) unless exits.include?('E')
          # line(i*10, j*10+10, i*10+10, j*10+10) unless exits.include?('S')
        elsif col[:tile] == end_tile
          exits = col[:chamber].next_spaces
          rectangle(i*10, j*10, 10, 10, :stroke_width=>1, :fill=> 'orange')
          # line(i*10, j*10, i*10+10, j*10) unless exits.include?('N')
          # line(i*10, j*10, i*10, j*10+10) unless exits.include?('W')
          # line(i*10+10, j*10, i*10+10, j*10+10) unless exits.include?('E')
          # line(i*10, j*10+10, i*10+10, j*10+10) unless exits.include?('S')
        end
      end
    end
  end
end

# intro = Introduction.new
#
# File.open("map.html", "w") do |f|
#   f.puts '<meta charset="utf-8">'
#   f.puts '<body>'
#   f.puts '<img src="map.svg">'
#
#   f.puts '<h3>Introduction</h3>'
#   f.puts "<p>#{intro.generate}</p>"
#
#   chambers.each_with_index do |(position, chamber), i|
#     f.puts "<h3>§ #{i+1}</h3>"
#     f.puts "<p>#{chamber.generate_text}</p>"
#     f.puts "<p>#{chamber.generate_exits}</p>"
#   end
#   f.puts '</body>'
# end
