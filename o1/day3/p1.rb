# We'll read the entire input file as a single string.
input = File.read('input.txt')

# We need to find all valid mul instructions of the form:
# mul(X,Y) where X and Y are each 1-3 digit integers and nothing else.
# Let's use a regular expression that matches:
#  - 'mul(' exactly
#  - one to three digits, followed by a comma, followed by one to three digits
#  - then a closing parenthesis
pattern = /\bmul\((\d{1,3}),(\d{1,3})\)/

sum = 0

input.scan(pattern) do |x, y|
  # Convert to integers, multiply, and add to sum
  sum += x.to_i * y.to_i
end

puts sum

