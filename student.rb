require 'lecture_time'

module RMU2011
  class Student

    attr_reader :name, :monday_hours, :wednesday_hours

    def initialize(name, monday_hours, wednesday_hours)
      @name = name.strip
      @monday_hours = parse_hours(monday_hours)
      @wednesday_hours = parse_hours(wednesday_hours)
    end


    def available_hours
      hours = {}
      hours[:monday] = monday_hours
      hours[:wednesday] = wednesday_hours

      hours
    end

    def to_s
      @name
    end

    def eql?(student)
      @name.eql?(student.name)
    end

    def hash
      @name.hash
    end

    private 

    def parse_hours(hours)
      parsed_hours = []
      hours.split(',').each do |hour|
        parsed_hours << LectureTime.new(hour)  
      end

      parsed_hours
    end

  end
end
