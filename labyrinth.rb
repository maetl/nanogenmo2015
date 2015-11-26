class RecursiveBacktracker
  def self.on(grid, start_at: grid.random_chamber)
    stack = []
    stack.push start_at

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

    grid
  end
end

class Labyrinth
  attr_reader :rows, :columns

  def initialize(rows, columns, grid)
    @rows = grid.count
    @columns = grid.first.count
    @grid = grid

    configure_cells
  end

  def size
    @rows * @columns
  end

  def random_chamber
    row = rand(@rows)
    column = rand(@grid[row].count)
    self[row, column]
  end

  def configure_cells
    each_cell do |cell|
      row, col = cell.row, cell.column
      cell.north = self[row - 1, col]
      cell.south = self[row + 1, col]
      cell.west  = self[row, col - 1]
      cell.east  = self[row, col + 1]
    end
  end

  def [](row, column)
    return nil unless row.between?(0, @rows - 1)
    return nil unless column.between?(0, @grid[row].count - 1)
    @grid[row][column]
  end

  def each_row
    @grid.each_with_index do |row, i|
      yield row, i
    end
  end

  def each_cell
    each_row do |row, x|
      row.each_with_index do |space, y|
        yield Chamber.new(x, y) if space
      end
    end
  end
end
