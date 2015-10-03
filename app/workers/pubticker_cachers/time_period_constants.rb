class TimePeriodConstants
    MINUTE = 1
    HALF_HOUR = 2
    HOUR = 3
    HALF_DAY = 4
    DAY = 5
    THREE_DAYS = 6
    WEEK = 7
#    THIRTY_DAYS = 8

    def initialize 
        @map = { MINUTE => lambda{ |periodEndTime| (periodEndTime - 60).to_s },
                 HALF_HOUR => lambda{ |periodEndTime| (periodEndTime - (60 * 30)).to_s },
                 HOUR => lambda{ |periodEndTime| (periodEndTime - (60 * 60)).to_s },
                 HALF_DAY => lambda{ |periodEndTime| (periodEndTime - (60 * 60 * 12)).to_s },
                 DAY => lambda{ |periodEndTime| (periodEndTime - (60 * 60 * 24)).to_s },
                 THREE_DAYS => lambda{ |periodEndTime| (periodEndTime - (60 * 60 * 24 * 3)).to_s },
                 WEEK => lambda{ |periodEndTime| (periodEndTime - (60 * 60 * 24 * 7)).to_s }
        }
    end

    def getBeginDate(timePeriod, endTime)
        unless endTime.is_a?(Time)
            raise ArgumentError, 'endTime object should be instance of Time'
        end

        func = @map.fetch(timePeriod)

        if func == nil
            raise ArgumentError, 'invalid time period, dont know how to process it.. :('
        end

        func.call(endTime)
    end
end
