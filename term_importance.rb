module RMU2011
  class TermImportance

    @@dummy = nil

    attr_reader :time_monday, :time_wednesday
    attr_reader :uniq, :repeated
    attr_reader :attendees_monday, :attendees_wednesday

    def self.dummy
      return @@dummy if @@dummy

      dummy = TermImportance.new(nil, nil, [], [])
      
      class << dummy
        attr_writer :uniq, :repeated
      end
      
      dummy.uniq = -1
      dummy.repeated = -1
      
      class << dummy
        protected
        attr_writer :uniq, :repeated
      end

      @@dummy = dummy
    end


    def initialize(time_monday, time_wednesday, attendees_monday, attendees_wednesday)
      @time_monday = time_monday
      @time_wednesday = time_wednesday
      @attendees_monday = attendees_monday.dup
      @attendees_wednesday = attendees_wednesday.dup

      tmp_attendees = (attendees_monday.dup << attendees_wednesday).flatten

      @uniq = tmp_attendees.uniq.size
      @repeated = tmp_attendees.size - @uniq
    end


    def <=>(term_importance)
      if @uniq != term_importance.uniq
        return @uniq <=> term_importance.uniq
      end
      @repeated <=> term_importance.repeated
    end

    def export
      %w(monday wednesday).each do |day|
        File.open("#{day}-roster.txt", 'w') do |file|
          file.puts(self.send("time_#{day}"))
          file.puts('')
          self.send("attendees_#{day}").each do |attendee|
            file.puts(attendee)
          end
        end
      end
    end

  end
end
