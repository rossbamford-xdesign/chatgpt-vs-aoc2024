# Read the input from input.txt
input = File.read("input.txt").split("\n")

# Separate the rules and updates
rules = []
updates = []
parsing_updates = false

input.each do |line|
  if line.strip.empty?
    parsing_updates = true
    next
  end

  if parsing_updates
    updates << line.split(",").map(&:to_i)
  else
    x, y = line.split("|").map(&:to_i)
    rules << [x, y]
  end
end

# Function to check if an update is valid according to the rules
def valid_update?(update, rules)
  positions = update.each_with_index.to_h
  rules.each do |x, y|
    # Only check rules involving pages that are present in the update
    if positions.key?(x) && positions.key?(y)
      return false if positions[x] >= positions[y]
    end
  end
  true
end

# Process each update and collect the middle page numbers of valid updates
middle_pages = []

updates.each do |update|
  if valid_update?(update, rules)
    middle_pages << update[update.size / 2]
  end
end

# Sum up the middle pages of valid updates
result = middle_pages.sum

# Output the result
puts result

