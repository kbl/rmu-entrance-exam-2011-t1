require 'test/unit'
require 'course'

module RMU2011
  class CourseTest < Test::Unit::TestCase

    def testShouldHaveThreeStudents
      course = Course.new('test_data.csv')

      assert course.students.size == 3
    end

    def testShouldFindPossibleAttendees
      course = Course.new('test_data.csv')
      attendees = course.possible_attendees(:monday, LectureTime.new('8:00 am EDT (12:00 UTC)'))
      time = LectureTime.new('8:00 pm EDT (00:00 UTC Tuesday)')

      assert attendees.size == 2
      assert attendees[0].to_s == 'Mylene Wilkinson'
      assert attendees[1].to_s == 'Marcin Pietraszek'

      assert course.possible_attendees(:monday, time)[0].to_s == 'Alfonzo Ferry'
    end

    def testShouldFindBestCourseTerm
      course = Course.new('test_data.csv')
      best_term = course.find_best_course_term

      assert best_term.uniq == 3
      assert best_term.repeated == 1
      assert best_term.time_monday.normalized == 12
      assert best_term.time_wednesday.normalized == 23
    end

  end
end
