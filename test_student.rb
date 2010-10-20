require 'test/unit'
require 'student'

module RMU2011
  class StudentTest < Test::Unit::TestCase

    def testAvailabilityHours
      student = Student.new('test', '8:00 am EDT (12:00 UTC)', '8:00 am EDT (12:00 UTC), 12:00 pm EDT (16:00 UTC)')
      
      monday = student.monday_hours
      assert monday.size == 1
      assert monday[0].to_s == '8:00 am EDT (12:00 UTC)'

      wednesday = student.wednesday_hours
      assert wednesday.size == 2
      assert wednesday[0].to_s == '8:00 am EDT (12:00 UTC)'
      assert wednesday[1].to_s == '12:00 pm EDT (16:00 UTC)'
    end

    def testStudentName
      student = Student.new('test', '', '')
      assert student.name == 'test'
    end

    def testAvailableHours
      student = Student.new('test', '8:00 am EDT (12:00 UTC)', '8:00 am EDT (12:00 UTC), 12:00 pm EDT (16:00 UTC)')

      available_hours = student.available_hours
      assert available_hours[:monday].size == 1
      assert available_hours[:wednesday].size == 2
    end

    def testToS
      student = Student.new('test ', '', '')
      assert student.to_s == 'test'
    end

    def testStudentsWithTheSameNameAreEqual
      student1 = Student.new('name', '', '')
      student2 = Student.new('name', '', '')
      student3 = Student.new('name2', '', '')

      assert [student1, student2, student3].uniq.size == 2
    end

  end
end
