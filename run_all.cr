#!/usr/bin/env crystal

require "colorize"

failing = [] of String

Dir["**/**.cr"].each do |x|
  next if x == "run_all.cr"

  puts "\n- RUN #{x}".colorize(:black).mode(:underline)

  op = system("cd #{File.dirname(x)} && crystal #{File.basename(x)}")

  unless op
    failing.push x
    puts "✗ FAILED #{x}".colorize(:red)
    next
  end

  puts "✓ DONE #{x}".colorize(:magenta)
end

puts

if failing.empty?
  puts "✓ SUCCESS".colorize(:green).mode(:bold)
else
  puts "✗ FAILING".colorize(:red).mode(:bold)

  failing.each do |f|
    puts "  #{f}"
  end

  exit 1
end
