# Function to calculate the similarity score
def similarity_score(left, right)
  # Count occurrences of each number in the right list
  right_counts = Hash.new(0)
  right.each { |num| right_counts[num] += 1 }

  # Calculate the similarity score
  score = 0
  left.each do |num|
    score += num * right_counts[num]
  end

  score
end

# Read the input from a file
def read_input(file_path)
  left = []
  right = []
  
  File.foreach(file_path) do |line|
    # Split each line into two numbers and add them to respective lists
    l, r = line.split.map(&:to_i)
    left << l
    right << r
  end
  
  [left, right]
end

# Main execution
if __FILE__ == $PROGRAM_NAME
  # Replace 'input.txt' with your actual file path
  input_file = 'input.txt'
  
  left_list, right_list = read_input(input_file)
  result = similarity_score(left_list, right_list)
  
  puts "Similarity Score: #{result}"
end

