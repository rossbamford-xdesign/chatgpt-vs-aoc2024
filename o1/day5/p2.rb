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
updates = update_lines.map { |line| line.split(",").map(&:strip) }

def update_correctly_ordered?(update, rules)
  # Filter rules to only those relevant for this update
  relevant_rules = rules.select { |x, y| update.include?(x) && update.include?(y) }
  
  # Index each page in the update for quick lookup
  page_index = {}
  update.each_with_index { |p, i| page_index[p] = i }

  relevant_rules.all? do |(x, y)|
    page_index[x] < page_index[y]
  end
end

correct_updates = []
incorrect_updates = []

updates.each do |update|
  if update_correctly_ordered?(update, rules)
    correct_updates << update
  else
    incorrect_updates << update
  end
end

# Helper method: topological sort using Kahn's algorithm
def topological_sort(nodes, edges)
  # nodes: array of node labels
  # edges: hash {node => [list of nodes it points to]}
  
  # Compute in-degrees
  in_degree = Hash.new(0)
  nodes.each { |n| in_degree[n] = 0 }
  
  edges.each_value do |neighbors|
    neighbors.each { |nbr| in_degree[nbr] += 1 }
  end

  # Queue for nodes with in_degree = 0
  queue = nodes.select { |n| in_degree[n] == 0 }
  sorted = []

  until queue.empty?
    n = queue.shift
    sorted << n
    (edges[n] || []).each do |nbr|
      in_degree[nbr] -= 1
      queue << nbr if in_degree[nbr] == 0
    end
  end

  # If sorted.size != nodes.size, that would indicate a cycle,
  # but per puzzle, we assume rules produce a valid ordering.
  
  sorted
end

def reorder_update(update, rules)
  # Filter rules relevant to this update
  relevant_rules = rules.select { |x, y| update.include?(x) && update.include?(y) }

  # Build graph
  nodes = update.uniq
  edges = Hash.new { |h, k| h[k] = [] }

  relevant_rules.each do |(x, y)|
    edges[x] << y
  end

  # Perform topological sort
  topological_sort(nodes, edges)
end

# Reorder the incorrect updates
reordered_updates = incorrect_updates.map { |u| reorder_update(u, rules) }

# Compute the sum of the middle page numbers of the reordered incorrect updates
sum = 0
reordered_updates.each do |u|
  mid_index = u.size / 2
  sum += u[mid_index].to_i
end

puts sum

