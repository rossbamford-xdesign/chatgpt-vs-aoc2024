rules = []
updates = []

# Read the input
input = File.read("input.txt").strip
parts = input.split("\n\n")

rule_lines = parts[0].split("\n")
update_lines = parts[1].split("\n")

# Parse rules: each line looks like "X|Y"
rule_lines.each do |line|
  left, right = line.split("|").map(&:strip)
  rules << [left, right]
end

# Parse updates: each line is comma-separated pages
update_lines.each do |line|
  pages = line.split(",").map(&:strip)
  updates << pages
end

correct_updates = []

updates.each do |update|
  # Filter rules to only those relevant for this update
  relevant_rules = rules.select do |(x, y)|
    update.include?(x) && update.include?(y)
  end

  # Check order
  # We can map each page in update to its index for quick look-up
  page_index = {}
  update.each_with_index { |p, i| page_index[p] = i }

  is_correct = relevant_rules.all? do |(x, y)|
    page_index[x] < page_index[y]
  end

  correct_updates << update if is_correct
end

# Sum the middle elements of correctly ordered updates
sum = 0
correct_updates.each do |u|
  middle_index = u.size / 2
  sum += u[middle_index].to_i
end

puts sum

