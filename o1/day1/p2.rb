# Read the input from input.txt
left_list = []
right_list = []

File.foreach("input.txt") do |line|
  left_num, right_num = line.split.map(&:to_i)
  left_list << left_num
  right_list << right_num
end

# Build a frequency map for the right list
right_freq = Hash.new(0)
right_list.each { |num| right_freq[num] += 1 }

# Calculate the similarity score
similarity_score = 0
left_list.each do |num|
  similarity_score += num * right_freq[num]
end

# Print the result
puts similarity_score
