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
input.scan(/#{mul_regex}|#{do_regex}|#{dont_regex}/).each do |match|
  if match[0] && match[1] # If it's a valid mul(X, Y) instruction
    if enabled
      sum += match[0].to_i * match[1].to_i
    else
      puts "skip"
    end
  elsif match[2] == "do()" # If it's a do() instruction
    puts "enable"
    enabled = true
  elsif match[3] == "don't()" # If it's a don't() instruction
    puts "disable"
    enabled = false
  end
end

# Output the final result
puts sum


