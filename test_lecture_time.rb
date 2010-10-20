require 'test/unit'
require 'lecture_time'

module RMU2011
  class LectureTimeTest < Test::Unit::TestCase

    def testShouldParseTimeInfo
      time = LectureTime.new('8:00 am EDT (12:00 UTC)')
      assert time.utc == '12:00 UTC', "'#{time.utc}' != '12:00 UTC'"
      assert time.edt == '8:00 am EDT', "'#{time.edt}' != '8:00 am EDT'"
    end

    def testEdgeCaseWithDayName
      time = LectureTime.new(' 8:00 pm EDT (00:00 UTC Tuesday)')
      assert time.to_s == '8:00 pm EDT (00:00 UTC Tuesday)', \
        "'#{time.to_s}' != '8:00 pm EDT (00:00 UTC Tuesday)'"
    end

    def testNormalizedTimeValue
      time = LectureTime.new(' 8:00 pm EDT (00:00 UTC Tuesday)')
      assert time.normalized == 0

      time = LectureTime.new(' 8:00 pm EDT (23:00 UTC)')
      assert time.normalized == 23
    end

    def testEquality
      time = LectureTime.new('8:00 pm EDT (00:00 UTC Tuesday)')
      time1 = LectureTime.new('8:00 pm EDT (00:00 UTC Tuesday)')

      assert time.eql?(time1), "#{time} != #{time1}"
      assert time.eql?(0), "#{time} != 0"
    end

    def testLectureTimeAsHashKey
      time = LectureTime.new('8:00 pm EDT (00:00 UTC Tuesday)')
      time1 = LectureTime.new('8:00 pm EDT (00:00 UTC Tuesday)')

      time_hash = {}
      time_hash[time] = 'bad data'
      time_hash[time1] = 'test'

      assert time_hash.size == 1
      assert time_hash[time] == 'test'
    end

    def testShouldHaveOnlyOneElementAsHashKey
      time = LectureTime.new('8:00 pm EDT (00:00 UTC Tuesday)')
      time1 = LectureTime.new('8:00 pm EDT (00:00 UTC Tuesday)')
      hash = {}

      hash[time] = time
      hash[time1] = time1
      assert hash.size == 1, 'hash size should be 1'
    end

  end
end
