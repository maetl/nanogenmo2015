require './dungeon'

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

  def neighbors
    list = []
    list << north if north
    list << south if south
    list << east if east
    list << west if west
    list
  end

  def neighbours_directions
    list = []
    list << 'N' if north
    list << 'S' if south
    list << 'E' if east
    list << 'W' if west
    list
  end

  def position
    [@row, @column]
  end

  def generate_text
    DungeonGenerator.generate
  end

  def generate_exits
    if neighbours_directions.empty?
      ['There is no way forward', 'You have come to a dead end.'].sample
    elsif neighbours_directions.size == 1
      "There is a passage leading #{cardinal_text(neighbours_directions.first)}."
    else
      "There are passages to the #{neighbours_directions.map { |d| cardinal_text(d) }.join(' and ')}."
    end
  end
end
