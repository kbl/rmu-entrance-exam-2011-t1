require 'test/unit'
require 'term_importance'

module RMU2011
  class TermImportanceTest < Test::Unit::TestCase

    def testShouldCountUniquAndRepatedAtendees
      ti = TermImportance.new('time monday', 'time wednesday', [1, 2, 3], [2, 5])

      assert ti.uniq == 4, "#{ti.uniq} != 4"
      assert ti.repeated == 1, "#{ti.repeated} != 1"
    end

    def testShouldSortTermsInRightOrder
      ti1 = TermImportance.new('time monday', 'time wednesday', [1, 2, 3], [2, 5])    # 4 1
      ti2 = TermImportance.new('time monday', 'time wednesday', [1, 2, 3], [2, 5, 3]) # 4 2
      ti3 = TermImportance.new('time monday', 'time wednesday', [1, 2, 3], [2])       # 3 1
      ti4 = TermImportance.new('time monday', 'time wednesday', [1, 3], [2])          # 3 0

      sorted = [ti4, ti3, ti2, ti1].sort.reverse

      assert sorted[0] == ti2
      assert sorted[1] == ti1
      assert sorted[2] == ti3
      assert sorted[3] == ti4
    end

    def testShouldCreateDummyObject
      dummy = TermImportance.dummy

      assert dummy.uniq == -1
      assert dummy.repeated == -1
      assert dummy.time_monday == nil
      assert dummy.time_wednesday == nil
    end

    def testShouldCreateOnlyOneInstanceOfDummyObject
      assert TermImportance.dummy === TermImportance.dummy
    end

    def testConstructorArgumentsShouldntBeChanged
      array1 = [1, 2]
      array2 = [3, 4]
      TermImportance.new('a', 'b', array1, array2)

      assert array1 == [1, 2], "#{array1} != [1, 2]"
      assert array2 == [3, 4], "#{array2} != [3, 4]"
    end

    def testTermImportanceShouldRememberPossibleAttendees
      array1 = [1, 2]
      array2 = [3, 4]
      term_importance = TermImportance.new('a', 'b', array1, array2)

      assert term_importance.attendees_monday == array1
      assert term_importance.attendees_wednesday == array2
      assert term_importance.attendees_monday != (array1 << 123)
      assert term_importance.attendees_wednesday != (array2 << 123)
    end

  end
end
