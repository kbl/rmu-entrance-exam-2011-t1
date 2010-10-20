require 'rubygems'
require 'bundler'
require 'fastercsv'

require 'student'

module RMU2011
  class StudentDataParser

    def initialize(file_path)
      @parser = FasterCSV.new(File.new(file_path))
      # thorw out header line
      @parser.shift
    end


    def parse_line
      return nil unless line = @parser.shift
      Student.new(line[0], line[1], line[2])
    end

  end
end
