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

# Locate the guard's starting position and direction
start_position = nil
start_direction = 0 # Default is up

map.each_with_index do |row, r|
  row.each_with_index do |cell, c|
    if "^>v<".include?(cell)
      start_position = [r, c]
      start_direction = "^>v<".index(cell)
      map[r][c] = "." # Clear the guard's starting position
      break
    end
  end
  break if start_position
end

# Function to simulate the guard's movement and detect loops
def simulate(map, directions, start_position, start_direction, obstruction = nil)
  visited_states = Set.new
  rows = map.size
  cols = map[0].size

  # Place the obstruction if specified
  if obstruction
    map[obstruction[0]][obstruction[1]] = "#"
  end

  # Initialize guard state
  guard_position = start_position
  guard_direction = start_direction

  loop do
    # Record the current state (position + direction)
    state = [guard_position, guard_direction]
    return true if visited_states.include?(state) # Loop detected
    visited_states.add(state)

    # Calculate the next position
    next_row = guard_position[0] + directions[guard_direction][0]
    next_col = guard_position[1] + directions[guard_direction][1]

    # Check if the guard is leaving the grid
    break if next_row < 0 || next_row >= rows || next_col < 0 || next_col >= cols

    # Check if the next position is blocked
    if map[next_row][next_col] == "#"
      # Turn right 90 degrees
      guard_direction = (guard_direction + 1) % 4
    else
      # Move forward
      guard_position = [next_row, next_col]
    end
  end

  # Remove the obstruction if it was placed
  map[obstruction[0]][obstruction[1]] = "." if obstruction

  false # No loop detected
end

# Find all valid positions for placing an obstruction
valid_positions = []
map.each_with_index do |row, r|
  row.each_with_index do |cell, c|
    if cell == "." && [r, c] != start_position
      valid_positions << [r, c]
    end
  end
end

# Test each position for creating a loop
loop_causing_positions = []
valid_positions.each do |position|
  if simulate(map.map(&:dup), directions, start_position, start_direction, position)
    loop_causing_positions << position
  end
end

# Output the number of loop-causing positions
puts loop_causing_positions.size

