# We'll read the map from input.txt, find the guard's starting position and direction,
# then simulate the guard's movements until they step outside the map.
#
# Rules:
# 1. If the cell in front of the guard is blocked by an obstacle (#) or outside the map,
#    the guard turns right (90 degrees clockwise) without moving.
# 2. Otherwise, the guard moves forward one step.
#
# The guard continues this protocol until they leave the map. We need to record all 
# distinct positions visited (including the initial position) and then print how many 
# distinct positions were visited.

# To handle direction:
# We'll keep track of the guard's direction as one of four states: up, right, down, left.
# Turning right changes the direction in the order: up -> right -> down -> left -> up
# We'll represent directions as vectors and have a small mapping for turning right.

# Steps:
# 1. Parse the input and find the guard's initial position and direction.
# 2. Set a visited set and add the starting position.
# 3. While guard is inside the map:
#    - Check the cell in front.
#       If out of bounds or '#', turn right.
#       Else, step forward into that cell, add to visited.
# 4. When a move would go outside the map, the simulation ends.
# 5. Print the size of visited.

# Note: The guard's initial character (^, >, v, <) also replaces that cell with '.' after
# extracting direction and position, so we have a consistent map.

# After finishing, print the count of visited cells.

map = File.readlines('input.txt', chomp: true)

rows = map.size
cols = map.first.size

# Directions and mapping
DIRECTIONS = {
  '^' => [-1, 0],
  'v' => [1, 0],
  '<' => [0, -1],
  '>' => [0, 1]
}

# Order of directions when turning right: up -> right -> down -> left
ORDERED_DIRECTIONS = [
  [-1, 0], # up
  [0, 1],  # right
  [1, 0],  # down
  [0, -1]  # left
]

# Find guard initial position and direction
guard_row = nil
guard_col = nil
guard_dir = nil

map.each_with_index do |line, r|
  line.chars.each_with_index do |ch, c|
    if DIRECTIONS.key?(ch)
      guard_row, guard_col = r, c
      guard_dir = DIRECTIONS[ch]
      # Replace the guard symbol with a '.' to treat it as open floor
      line[c] = '.'
      map[r] = line
      break
    end
  end
  break if guard_row
end

visited = Set.new
visited.add([guard_row, guard_col])

def direction_index(dir)
  ORDERED_DIRECTIONS.index(dir)
end

def turn_right(dir)
  i = direction_index(dir)
  ORDERED_DIRECTIONS[(i + 1) % 4]
end

# Simulation
current_row, current_col = guard_row, guard_col
dir = guard_dir

loop do
  # Check cell in front
  next_r = current_row + dir[0]
  next_c = current_col + dir[1]

  # Check if next is out of bounds
  if next_r < 0 || next_r >= rows || next_c < 0 || next_c >= cols
    # Moving forward would leave the map, so we end.
    break
  end

  next_cell = map[next_r][next_c]

  if next_cell == '#'
    # Turn right
    dir = turn_right(dir)
  else
    # Move forward
    current_row = next_r
    current_col = next_c
    visited.add([current_row, current_col])
  end

  # If after turning there's still obstacle ahead on next loop, turn right again, etc.
  # The loop continues until we step outside or we can move forward.
end

puts visited.size

