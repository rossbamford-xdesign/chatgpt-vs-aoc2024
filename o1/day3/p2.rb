# We'll read the entire input file as a single string.
input = File.read('input.txt')

# We need to find and handle three types of instructions:
# - do()    : Enables future mul instructions.
# - don't() : Disables future mul instructions.
# - mul(X,Y): Multiplies two integers if enabled.
#
# Initially, mul instructions are enabled.

# We'll scan the input for these instructions in the order they appear.
# A suitable regex could match all three at once. We'll use alternation:
#
#   do\(\)          matches do()
#   don't\(\)       matches don't()
#   mul\((\d{1,3}),(\d{1,3})\) matches mul(X,Y) with 1-3 digits each
#
# Use a single regex and a scan with captures.

pattern = /\bdo\(\)|\bdon't\(\)|\bmul\((\d{1,3}),(\d{1,3})\)/

enabled = true
sum = 0

input.scan(pattern) do |x, y|
  # This block will be called for every match. The captures for mul will be in x, y.
  # For do() and don't(), x and y will be nil.
  
  if $&.start_with?("do(")
    enabled = true
  elsif $&.start_with?("don't(")
    enabled = false
  elsif $&.start_with?("mul(")
    # Only add if enabled
    if enabled
      sum += x.to_i * y.to_i
    end
  end
end

puts sum
