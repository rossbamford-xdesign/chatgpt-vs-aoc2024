# We need to find patterns in the shape of an 'X', where each diagonal passing through the center 'A' forms either
# the string "MAS" or "SAM". The pattern looks like this (with center at position (r,c)):
#
# (r-1, c-1)    (r-1, c+1)
#       \       /
#        A (r,c)
#       /       \
# (r+1, c-1)    (r+1, c+1)
#
# Each diagonal must form "MAS" or "SAM" along its three positions, with the center shared A.
#
# That means:
# For the diagonal from top-left to bottom-right:
#   (r-1,c-1), (r,c), (r+1,c+1) must be either M-A-S or S-A-M.
#
# For the diagonal from top-right to bottom-left:
#   (r-1,c+1), (r,c), (r+1,c-1) must be either M-A-S or S-A-M.
#
# We must find all occurrences in the grid.

def diagonal_matches?(line)
  # line is an array of 3 chars, must be M-A-S or S-A-M
  line == ['M','A','S'] || line == ['S','A','M']
end

grid = File.readlines("input.txt", chomp: true)
rows = grid.size
cols = grid.first.size

count = 0

(1...rows-1).each do |r|
  (1...cols-1).each do |c|
    next unless grid[r][c] == 'A'

    # Check diagonals:
    # Diagonal 1: top-left to bottom-right
    diag1 = [grid[r-1][c-1], grid[r][c], grid[r+1][c+1]]

    # Diagonal 2: top-right to bottom-left
    diag2 = [grid[r-1][c+1], grid[r][c], grid[r+1][c-1]]

    if diagonal_matches?(diag1) && diagonal_matches?(diag2)
      count += 1
    end
  end
end

puts count

