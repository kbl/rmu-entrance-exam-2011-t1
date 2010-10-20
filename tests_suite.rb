require 'test/unit/testsuite'
require 'test/unit/ui/console/testrunner'

require 'test_student'
require 'test_student_data_parser'
require 'test_lecture_time'
require 'test_course'
require 'test_term_importance'

module RMU2011
  class TestSuite

    def self.suite
      suite = Test::Unit::TestSuite.new

      suite << StudentDataParserTest.suite
      suite << LectureTimeTest.suite
      suite << StudentTest.suite
      suite << CourseTest.suite
      suite << TermImportanceTest.suite

      suite
    end

  end
  
  Test::Unit::UI::Console::TestRunner.run(TestSuite)
end

