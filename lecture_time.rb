module RMU2011
  class LectureTime

    attr_reader :utc, :edt, :normalized

    def initialize(time)
      @edt, @utc = time.split(/[\(\)]/).each { |t| t.strip! }
      @normalized = Integer(@utc.split(':')[0])
    end

    def to_s
      "#{edt} (#{utc})"
    end

    def eql?(lecture_time)
      return @normalized.eql?(lecture_time.normalized) if lecture_time.respond_to?(:normalized)
      @normalized.eql?(lecture_time)
    end

    def hash
      @normalized.hash
    end

    def ==(lecture_time)
      @normalized == lecture_time.normalized
    end

  end
end
