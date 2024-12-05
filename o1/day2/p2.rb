def safe?(levels)
  return true if levels.size <= 2 # Any sequence of length <= 2 is trivially safe

  diffs = []
  (0...(levels.size - 1)).each do |i|
    diffs << levels[i+1] - levels[i]
  end

  # Check if all differences are in the range 1 to 3 or -1 to -3
  # and all are same sign (either all positive or all negative)
  all_increasing = diffs.all? { |d| d.between?(1, 3) }
  all_decreasing = diffs.all? { |d| d.between?(-3, -1) }

  all_increasing || all_decreasing
end

lines = File.readlines("input.txt", chomp: true)
safe_count = 0

lines.each do |line|
  levels = line.split.map(&:to_i)

  # First check if the report is already safe
  if safe?(levels)
    safe_count += 1
  else
    # If not safe, try removing one level at a time and check again
    removable_safe = false
    levels.each_with_index do |_, idx|
      new_levels = levels[0...idx] + levels[(idx+1)..-1]
      if safe?(new_levels)
        removable_safe = true
        break
      end
    end
    safe_count += 1 if removable_safe
  end
end

puts safe_count

