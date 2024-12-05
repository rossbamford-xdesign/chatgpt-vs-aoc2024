# Read the content of the file
input = File.read("input.txt")

# Regular expression to match valid `mul(X,Y)` instructions
# Matches the pattern "mul(NUM1,NUM2)" where NUM1 and NUM2 are 1-3 digit numbers
regex = /mul\((\d{1,3}),(\d{1,3})\)/

# Scan the input for valid instructions and compute their products
sum = input.scan(regex).reduce(0) do |total, (x, y)|
  total + x.to_i * y.to_i
end

# Output the final result
puts sum


