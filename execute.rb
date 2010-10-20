#!/usr/bin/ruby -w

require 'course'

include RMU2011

if ARGV.size != 1
  puts 'usage: $execute.rb path-to-file'
  exit
end

course = Course.new(ARGV[0])

best_term = course.find_best_course_term
best_term.export
