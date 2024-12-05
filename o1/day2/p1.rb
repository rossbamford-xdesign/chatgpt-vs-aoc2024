# Read all lines from input.txt
lines = File.readlines("input.txt", chomp: true)

safe_count = 0

lines.each do |line|
  # Parse the report levels into an array of integers
  levels = line.split.map(&:to_i)

  # Compute differences between consecutive levels
  diffs = []
  (0...(levels.size - 1)).each do |i|
    diffs << levels[i+1] - levels[i]
  end

  # Check if all differences are either positive or all negative
  all_increasing = diffs.all? { |d| d > 0 && d >= 1 && d <= 3 }
  all_decreasing = diffs.all? { |d| d < 0 && d <= -1 && d >= -3 }

  # If they are all increasing or all decreasing, increment safe count
  safe_count += 1 if all_increasing || all_decreasing
end

puts safe_count

