require 'set'

# Read the map from the input file
map = File.readlines("input.txt", chomp: true).map(&:chars)

# Directions: Up, Right, Down, Left
directions = [
  [-1, 0], # Up
  [0, 1],  # Right
  [1, 0],  # Down
  [0, -1]  # Left
]

# Find the guard's starting position and initial direction
start_position = nil
direction_index = 0 # Default is up

map.each_with_index do |row, r|
  row.each_with_index do |cell, c|
    if "^>v<".include?(cell)
      start_position = [r, c]
      direction_index = "^>v<".index(cell)
      map[r][c] = "." # Clear the guard's starting position
      break
    end
  end
  break if start_position
end

# Track visited positions
visited_positions = Set.new
visited_positions.add(start_position)

# Initialize the guard's position
guard_position = start_position

# Simulate the guard's movement
rows = map.size
cols = map[0].size

loop do
  # Calculate the next position based on the current direction
  next_row = guard_position[0] + directions[direction_index][0]
  next_col = guard_position[1] + directions[direction_index][1]
  next_position = [next_row, next_col]

  # Check if the guard is about to leave the grid
  if next_row < 0 || next_row >= rows || next_col < 0 || next_col >= cols
    break
  end

  # Check if the next position is blocked
  if map[next_row][next_col] == "#"
    # Turn right 90 degrees
    direction_index = (direction_index + 1) % 4
  else
    # Move forward to the next position
    guard_position = next_position
    visited_positions.add(guard_position)
  end
end

# Output the number of distinct positions visited
puts visited_positions.size

