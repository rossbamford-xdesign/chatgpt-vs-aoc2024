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

# Function to sort an update according to the rules
def sort_update(update, rules)
  dependency_graph = Hash.new { |hash, key| hash[key] = [] }
  rules.each do |x, y|
    # Only include rules involving pages in the update
    if update.include?(x) && update.include?(y)
      dependency_graph[x] << y
    end
  end

  # Perform a topological sort
  sorted = []
  visited = {}
  visiting = {}

  visit = lambda do |node|
    return if visited[node]
    raise "Cycle detected!" if visiting[node]

    visiting[node] = true
    dependency_graph[node].each { |neighbor| visit.call(neighbor) }
    visiting[node] = false
    visited[node] = true
    sorted.unshift(node)
  end

  update.each { |page| visit.call(page) unless visited[page] }
  sorted
end

# Process each update
incorrect_middle_pages = []

updates.each do |update|
  if !valid_update?(update, rules)
    sorted_update = sort_update(update, rules)
    incorrect_middle_pages << sorted_update[sorted_update.size / 2]
  end
end

# Sum up the middle pages of corrected updates
result = incorrect_middle_pages.sum

# Output the result
puts result

