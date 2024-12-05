# We'll read the entire puzzle from input.txt and then scan for all occurrences of the word "XMAS".
# The word "XMAS" must be found in all 8 possible directions:
# - Horizontal (left to right and right to left)
# - Vertical (top to bottom and bottom to top)
# - Diagonal (4 directions: top-left to bottom-right, bottom-right to top-left,
#   top-right to bottom-left, and bottom-left to top-right)
#
# Steps:
# 1. Read lines from input.txt into an array of strings.
# 2. Scan each position (r,c) in the grid.
# 3. For each position, check all 8 directions to see if "XMAS" starts there.
# 4. Count the total occurrences.
#
# We'll assume the puzzle is square or rectangular and that it's large enough to possibly contain "XMAS".
# If not specified, we'll just handle any rectangular input.

WORD = "XMAS"
DIRECTIONS = [
  [0, 1],   # horizontal (left to right)
  [0, -1],  # horizontal (right to left)
  [1, 0],   # vertical (top to bottom)
  [-1, 0],  # vertical (bottom to top)
  [1, 1],   # diagonal down-right
  [-1, -1], # diagonal up-left
  [1, -1],  # diagonal down-left
  [-1, 1]   # diagonal up-right
]

grid = File.readlines("input.txt", chomp: true)
rows = grid.size
cols = grid.first.size

count = 0

(0...rows).each do |r|
  (0...cols).each do |c|
    DIRECTIONS.each do |dr, dc|
      # Check if "XMAS" can fit in this direction
      rr, cc = r, c
      found = true
      WORD.chars.each do |ch|
        if rr < 0 || rr >= rows || cc < 0 || cc >= cols || grid[rr][cc] != ch
          found = false
          break
        end
        rr += dr
        cc += dc
      end
      count += 1 if found
    end
  end
end

puts count

