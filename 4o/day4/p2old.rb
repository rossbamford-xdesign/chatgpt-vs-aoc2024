# Load the word search from the input file
grid = File.readlines("input.txt").map(&:chomp)

# Dimensions of the grid
rows = grid.size
cols = grid.first.size

# Function to check if an X-MAS pattern exists at a given center point
def x_mas_exists?(grid, center_row, center_col)
  rows = grid.size
  cols = grid.first.size

  # Coordinates for the "X-MAS" pattern
  arms = [
    [-1, -1], [1, 1],  # Top-left to bottom-right
    [-1, 1], [1, -1]   # Top-right to bottom-left
  ]

  # Check both diagonals for "MAS"
  arms.each_slice(2).all? do |(dx1, dy1), (dx2, dy2)|
    # Diagonal one
    diag1 = (0..2).map { |step| [center_row + step * dx1, center_col + step * dy1] }
    # Diagonal two
    diag2 = (0..2).map { |step| [center_row + step * dx2, center_col + step * dy2] }

    # Ensure all coordinates are in bounds
    [diag1, diag2].all? do |diag|
      diag.all? { |r, c| r >= 0 && r < rows && c >= 0 && c < cols }
    end &&
      # Check if each diagonal forms "MAS" forwards or backwards
      (diag1.map { |r, c| grid[r][c] }.join == "MAS" ||
       diag1.map { |r, c| grid[r][c] }.join == "SAM") &&
      (diag2.map { |r, c| grid[r][c] }.join == "MAS" ||
       diag2.map { |r, c| grid[r][c] }.join == "SAM")
  end
end

# Count total occurrences of X-MAS in the grid
x_mas_count = 0

(1...rows - 1).each do |r|
  (1...cols - 1).each do |c|
    x_mas_count += 1 if x_mas_exists?(grid, r, c)
  end
end

puts "Total occurrences of X-MAS: #{x_mas_count}"

