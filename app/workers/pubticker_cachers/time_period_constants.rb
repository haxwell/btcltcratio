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
    # I use DateTime.parse because it loses the milliseconds.. simplifies queries, I think.

        @map = { MINUTE => lambda{ |periodEndDateTime| DateTime.parse(periodEndDateTime.ago(60).to_s) },
                 HALF_HOUR => lambda{ |periodEndDateTime| DateTime.parse(periodEndDateTime.ago(60 * 30).to_s) },
                 HOUR => lambda{ |periodEndDateTime| DateTime.parse(periodEndDateTime.ago(60 * 60).to_s) },
                 HALF_DAY => lambda{ |periodEndDateTime| DateTime.parse(periodEndDateTime.ago(60 * 60 * 12).to_s) },
                 DAY => lambda{ |periodEndDateTime| DateTime.parse(periodEndDateTime.ago(60 * 60 * 24).to_s) },
                 THREE_DAYS => lambda{ |periodEndDateTime| DateTime.parse(periodEndDateTime.ago(60 * 60 * 24 * 3).to_s) },
                 WEEK => lambda{ |periodEndDateTime| DateTime.parse(periodEndDateTime.ago(60 * 60 * 24 * 7).to_s) }
        }
    end

    def getBeginDate(timePeriod, endDate)
        unless endDate.is_a?(DateTime)
            raise ArgumentError, 'endDate object should be instance of DateTime'
        end

        func = @map.fetch(timePeriod)

        if func == nil
            raise ArgumentError, 'invalid time period, dont know how to process it.. :('
        end

        func.call(endDate.to_datetime)
    end
end
