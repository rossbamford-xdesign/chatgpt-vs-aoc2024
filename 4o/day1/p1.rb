# Function to calculate the total distance between two lists
def total_distance(left, right)
  # Sort both lists
  sorted_left = left.sort
  sorted_right = right.sort

  # Pair up numbers and calculate the distances
  total = 0
  sorted_left.each_with_index do |val, index|
    total += (val - sorted_right[index]).abs
  end

  total
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
  result = total_distance(left_list, right_list)
  
  puts "Total Distance: #{result}"
end

