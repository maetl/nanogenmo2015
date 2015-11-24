require './dungeon'

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
