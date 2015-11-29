class Space
  attr_reader :position, :next_spaces

  def initialize(position, next_spaces)
    @position = position
    @next_spaces = next_spaces
  end
end
