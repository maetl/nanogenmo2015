class Labyrinth
  attr_reader :grid

  def initialize(size=700)
    @size = size
    @spaces = {}
  end

  def generate
    scatter_spaces
    translate_to_origin
    connect_grid
    link_pathways
    number_sections
    self
  end

  def connect_grid
    @grid.each do |row|
      row.each do |cell|
        if cell
          cell.north = grid_pointer(cell.position, 'N')
          cell.south = grid_pointer(cell.position, 'S')
          cell.west  = grid_pointer(cell.position, 'W')
          cell.east  = grid_pointer(cell.position, 'E')
        end
      end
    end
  end

  def grid_pointer(position, direction)
    x, y = Directions.move(position, direction)
    @grid[x][y] unless @grid[x].nil?
  end

  def link_pathways
    stack = []
    stack.push(start_chamber)

    while stack.any?
      current = stack.last
      neighbors = current.neighbors.select { |n| n.links.empty? }
      if neighbors.empty?
        stack.pop
      else
        neighbor = neighbors.sample
        current.link(neighbor)
        stack.push(neighbor)
      end
    end
  end

  def translate_to_origin
    width = max_x - min_x
    height = max_y - min_y
    origin = 0

    @grid = Array.new(width) { Array.new(height, false) }

    origin.upto(width-1) do |x|
      origin.upto(height-1) do |y|
        if @spaces.key?([x + min_x, y + min_y])
          @grid[x][y] = Chamber.new(x, y)
        else
          # @grid[x][y] = false
        end
      end
    end
  end

  def number_sections
    chambers.each_with_index do |chamber, i|
      chamber.section_number(i + 1)
    end
  end

  def scatter_spaces
    add_space([0,0])
  end

  def start_chamber
    x,y = @spaces.keys.min_by { |(x, y)| x }
    @grid[x][y]
  end

  def max_x
    @max_x ||= @spaces.keys.max_by { |(x, y)| x }.first
  end

  def max_y
    @max_y ||= @spaces.keys.max_by { |(x, y)| y }.last
  end

  def min_x
    @min_x ||= @spaces.keys.min_by { |(x, y)| x }.first
  end

  def min_y
    @min_y ||= @spaces.keys.min_by { |(x, y)| y }.last
  end

  def move_next(position)
    next_spaces = Directions::CARDINAL_POINTS.reject do |direction|
      @spaces.key?(Directions.move(position, direction))
    end

    next_spaces.sample(rand(1..3))
  end

  def add_space(position)
    return if @spaces.count >= @size

    next_spaces = move_next(position)

    @spaces[position] = Space.new(position, next_spaces)

    next_spaces.each do |direction|
      add_space(Directions.move(position, direction))
    end
  end

  def chambers
    @grid.flatten.select { |chamber| chamber.is_a?(Chamber) }.shuffle
  end

  def dump_map
    @grid.each do |row|
      buffer = String.new
      row.each do |cell|
        if cell
          buffer << '#'
        else
          buffer << ' '
        end
      end
      puts buffer
    end
  end
end
