# Load the word search from the input file
grid = File.readlines("input.txt").map(&:chomp)

# Define the word to search for
word = "XMAS"

# Dimensions of the grid
rows = grid.size
cols = grid.first.size

# Directions for traversal: horizontal, vertical, and all diagonals
DIRECTIONS = [
  [0, 1],  # Right
  [1, 0],  # Down
  [0, -1], # Left
  [-1, 0], # Up
  [1, 1],  # Down-right diagonal
  [1, -1], # Down-left diagonal
  [-1, 1], # Up-right diagonal
  [-1, -1] # Up-left diagonal
]

# Function to count occurrences of the word in a specific direction
def count_word_in_direction(grid, word, start_row, start_col, dir_row, dir_col)
  rows = grid.size
  cols = grid.first.size
  word_length = word.length
  count = 0

  # Traverse the grid in the specified direction
  (0...word_length).each do |step|
    r = start_row + step * dir_row
    c = start_col + step * dir_col
    break if r < 0 || r >= rows || c < 0 || c >= cols
    break if grid[r][c] != word[step]
    count += 1 if step == word_length - 1
  end
  count > 0 ? 1 : 0
end

# Count total occurrences of the word in the grid
total_count = 0

rows.times do |r|
  cols.times do |c|
    DIRECTIONS.each do |dir_row, dir_col|
      total_count += count_word_in_direction(grid, word, r, c, dir_row, dir_col)
    end
  end
end

puts "Total occurrences of '#{word}': #{total_count}"

