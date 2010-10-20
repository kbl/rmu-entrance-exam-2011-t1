require 'test/unit'
require 'student_data_parser'

module RMU2011
  class StudentDataParserTest < Test::Unit::TestCase

    def testShouldReadApropriateStudentName
      sdp = StudentDataParser.new('test_data.csv')
      
      student = sdp.parse_line
      assert student.name == 'Mylene Wilkinson'
    end

    def testShouldReadApropriateStudentAvailabilityHours
      sdp = StudentDataParser.new('test_data.csv')
      
      student = sdp.parse_line
      assert student.monday_hours[0].to_s == '8:00 am EDT (12:00 UTC)'
      assert student.monday_hours[1].to_s == '12:00 pm EDT (16:00 UTC)'
      assert student.wednesday_hours[0].to_s == '8:00 am EDT (12:00 UTC)'
      assert student.wednesday_hours[1].to_s == '12:00 pm EDT (16:00 UTC)'

      student = sdp.parse_line
      assert student.monday_hours[0].to_s == '7:00 pm EDT (23:00 UTC)'
      assert student.monday_hours[1].to_s == '8:00 pm EDT (00:00 UTC Tuesday)'
      assert student.wednesday_hours[0].to_s == '7:00 pm EDT (23:00 UTC)'
      assert student.wednesday_hours[1].to_s == '8:00 pm EDT (00:00 UTC Thursday)'
    end

  end
end
