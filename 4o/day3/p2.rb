# Read the content of the file
input = File.read("input.txt")

# Regular expressions for the instructions
mul_regex = /mul\((\d{1,3}),(\d{1,3})\)/
do_regex = /do\(\)/
dont_regex = /don't\(\)/

# State to track whether mul instructions are enabled
enabled = true

# Variable to store the final sum
sum = 0

# Process the input character by character
input.scan(/mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)/).each do |token|
  if token.match?(mul_regex) # If it's a valid mul(X, Y) instruction
    if enabled
      x, y = token.match(mul_regex).captures
      sum += x.to_i * y.to_i
    end
  elsif token.match?(do_regex) # If it's a do() instruction
    enabled = true
  elsif token.match?(dont_regex) # If it's a don't() instruction
    enabled = false
  end
end

# Output the final result
puts sum

