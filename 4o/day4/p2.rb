# Load the word search from the input file
grid = File.readlines("input.txt").map(&:chomp)

# Dimensions of the grid
rows = grid.size
cols = grid.first.size

# Function to validate one diagonal (3 cells in a straight line)
def diagonal_matches?(grid, center_row, center_col, deltas)
  word = deltas.map do |(dx, dy)|
    r, c = center_row + dx, center_col + dy
    return nil if r < 0 || r >= grid.size || c < 0 || c >= grid.first.size
    grid[r][c]
  end.join
  word == "MAS" || word == "SAM"
end

# Count occurrences of X-MAS
x_mas_count = 0

# Iterate through possible center points in the grid
(1...rows - 1).each do |r|
  (1...cols - 1).each do |c|
    # Check diagonals from the current center point
    if diagonal_matches?(grid, r, c, [[-1, -1], [0, 0], [1, 1]]) && # Top-left to bottom-right
       diagonal_matches?(grid, r, c, [[-1, 1], [0, 0], [1, -1]])    # Top-right to bottom-left
      x_mas_count += 1
    end
  end
end

puts "Total occurrences of X-MAS: #{x_mas_count}"

