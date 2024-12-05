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

def count_safe_reports(file_path)
  reports = parse_input(file_path)
  reports.count { |report| safe_report?(report) }
end

# Usage
file_path = "input.txt" # Replace with your file path
puts count_safe_reports(file_path)


