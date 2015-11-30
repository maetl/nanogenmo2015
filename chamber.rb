require './dungeon'
require 'active_support/core_ext/array'

DungeonGenerator = Dungeon.new

class Chamber
  attr_reader :row, :column
  attr_accessor :north, :south, :east, :west
  attr_accessor :exits

  def initialize(row, column)
    @row = row
    @column = column
    @links = {}
  end

  def link(cell, bidi=true)
    @links[cell] = true
    cell.link(self, false) if bidi
    self
  end

  def unlink(cell, bidi=true)
    @links.delete(cell)
    cell.unlink(self, false) if bidi
    self
  end

  def links
    @links.keys
  end

  def linked?(cell)
    @links.key?(cell)
  end

  def section_number(number)
    @section_number = number
  end

  def section
    @section_number
  end

  def section_heading
    "§ #{@section_number}"
  end

  def neighbors_map
    hash = {}
    hash['N'] = north if north
    hash['S'] = south if south
    hash['E'] = east if east
    hash['W'] = west if west
    hash
  end

  def neighbors
    neighbors_map.values
  end

  def neighbours_directions
    neighbors_map.keys
  end

  def neighbours_text_list
    neighbours_directions.map { |d| Directions.cardinal_text(d).upcase }
  end

  def neighbours_text
    neighbours_text_list.to_sentence
  end

  def position
    [@row, @column]
  end

  def section_body
    DungeonGenerator.generate
  end

  def generate_exits
    if neighbours_directions.size == 1
      "There is a passage leading #{neighbours_text}."
    else
      "There are passages to the #{neighbours_text}."
    end
  end

  def exit_directions
    neighbors_map.inject([]) do |dirs, (key, chamber)|
      dirs << "- To go #{Directions.cardinal_text(key).upcase} turn to #{chamber.section_heading}"
    end.join("\n")
  end
end
