require 'set'

map = File.readlines('input.txt', chomp: true).map(&:chars)

rows = map.size
cols = map.first.size

# Directions
DIRECTIONS = {
  '^' => [-1, 0],
  'v' => [1, 0],
  '<' => [0, -1],
  '>' => [0, 1]
}

ORDERED_DIRECTIONS = [
  [-1, 0], # up
  [0, 1],  # right
  [1, 0],  # down
  [0, -1]  # left
]

def direction_index(dir)
  ORDERED_DIRECTIONS.index(dir)
end

def turn_right(dir)
  i = direction_index(dir)
  ORDERED_DIRECTIONS[(i + 1) % 4]
end

# Find guard initial position and direction
guard_row = nil
guard_col = nil
guard_dir = nil
map.each_with_index do |line, r|
  line.each_with_index do |ch, c|
    if DIRECTIONS.key?(ch)
      guard_row, guard_col = r, c
      guard_dir = DIRECTIONS[ch]
      map[r][c] = '.' # replace guard with floor
      break
    end
  end
  break if guard_row
end

def simulate_with_obstacle(map, obstacle_r, obstacle_c, guard_start_r, guard_start_c, guard_start_dir)
  new_map = map.map(&:dup)
  new_map[obstacle_r][obstacle_c] = '#'

  current_r, current_c = guard_start_r, guard_start_c
  dir = guard_start_dir
  visited_states = Set.new

  loop do
    state = [current_r, current_c, direction_index(dir)]
    return true if visited_states.include?(state)  # Loop detected
    visited_states.add(state)

    # Determine the cell in front
    next_r = current_r + dir[0]
    next_c = current_c + dir[1]

    # Check out-of-bounds (guard would leave the map)
    if next_r < 0 || next_r >= new_map.size || next_c < 0 || next_c >= new_map[0].size
      return false # guard leaves map successfully
    end

    # Check for obstacle
    if new_map[next_r][next_c] == '#'
      # turn right
      dir = turn_right(dir)
    else
      # move forward
      current_r, current_c = next_r, next_c
    end
  end
end

count = 0
(0...rows).each do |r|
  (0...cols).each do |c|
    # Place obstacle only on '.' cells and not on the guard's start
    next unless map[r][c] == '.'
    next if r == guard_row && c == guard_col

    if simulate_with_obstacle(map, r, c, guard_row, guard_col, guard_dir)
      count += 1
    end
  end
end

puts count

