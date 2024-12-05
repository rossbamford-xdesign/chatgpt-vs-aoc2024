# Read the input from input.txt
left_list = []
right_list = []

File.foreach("input.txt") do |line|
  # Each line should contain two integers separated by some whitespace
  left_num, right_num = line.split.map(&:to_i)
  left_list << left_num
  right_list << right_num
end

# Sort both lists
left_list.sort!
right_list.sort!

# Compute the sum of distances
total_distance = left_list.zip(right_list).map { |l, r| (l - r).abs }.sum

# Print the result
puts total_distance

