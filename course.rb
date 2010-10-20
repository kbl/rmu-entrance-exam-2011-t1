require 'student_data_parser'
require 'term_importance'

module RMU2011
  class Course

    attr_reader :students

    def initialize(attendee_list_path)
      @students = []
      @possible_attendees = {}

      parse_student_data(attendee_list_path)
    end

    def possible_attendees(day, hour)
      begin
        @possible_attendees[day][hour]      
      rescue
        []
      end
    end

    def find_best_course_term
      return @@best_term if @@best_term

      best_term = TermImportance.dummy
      @possible_attendees[:monday].each do |hour_monday, possible_attendees_monday|
        @possible_attendees[:wednesday].each do |hour_wednesday, possible_attendees_wednesday|
          temp_term = TermImportance.new(
            hour_monday,
            hour_wednesday, 
            possible_attendees_monday,
            possible_attendees_wednesday)

          best_term = temp_term if (best_term <=> temp_term) == -1
        end
      end

      @@best_term = best_term
    end

    private

    @@best_term = nil

    def parse_student_data(attendee_list_path)
      student_data_parser = StudentDataParser.new(attendee_list_path) 

      while student = student_data_parser.parse_line do
        @students << student
        update_possible_attendees(student)
      end
    end

    def update_possible_attendees(student)
      student.available_hours.each do |day, hours_list|
        day_attendees = @possible_attendees[day] || @possible_attendees[day] = {}
        hours_list.each do |hour|
          hour_attendees = day_attendees[hour] || day_attendees[hour] = []
          (hour_attendees << student).uniq!
        end
      end
    end

  end
end
