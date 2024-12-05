def parse_input(file_path)
  File.readlines(file_path).map { |line| line.split.map(&:to_i) }
end

def safe_report?(report)
  diffs = report.each_cons(2).map { |a, b| b - a }
  
  # Rule 1: All differences are either positive (increasing) or negative (decreasing)
  all_increasing = diffs.all? { |diff| diff > 0 }
  all_decreasing = diffs.all? { |diff| diff < 0 }
  
  # Rule 2: Differences are between -3 and -1, or 1 and 3
  valid_diffs = diffs.all? { |diff| diff.abs.between?(1, 3) }
  
  (all_increasing || all_decreasing) && valid_diffs
end

def safe_with_dampener?(report)
  return true if safe_report?(report)
  
  # Try removing each level and check if the resulting report is safe
  (0...report.size).any? do |i|
    modified_report = report[0...i] + report[i+1..-1]
    safe_report?(modified_report)
  end
end

def count_safe_reports_with_dampener(file_path)
  reports = parse_input(file_path)
  reports.count { |report| safe_with_dampener?(report) }
end

# Usage
file_path = "input.txt" # Replace with your file path
puts count_safe_reports_with_dampener(file_path)

