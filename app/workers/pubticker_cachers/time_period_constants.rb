class TimePeriodConstants
    MINUTE = 1
    HALF_HOUR = 2
    HOUR = 3
    HALF_DAY = 4
    DAY = 5
    THREE_DAYS = 6
    WEEK = 7
    THIRTY_DAYS = 8
    SIXTY_DAYS = 9
    NINETY_DAYS = 10
    ONE_HUNDRED_EIGHTY_DAYS = 11
    YEAR = 12

    def initialize 
        @map = { MINUTE => lambda{ |periodEndTime| (periodEndTime - 60) },
                 HALF_HOUR => lambda{ |periodEndTime| (periodEndTime - (60 * 30)) },
                 HOUR => lambda{ |periodEndTime| (periodEndTime - (60 * 60)) },
                 HALF_DAY => lambda{ |periodEndTime| (periodEndTime - (60 * 60 * 12)) },
                 DAY => lambda{ |periodEndTime| (periodEndTime - (60 * 60 * 24)) },
                 THREE_DAYS => lambda{ |periodEndTime| (periodEndTime - (60 * 60 * 24 * 3)) },
                 WEEK => lambda{ |periodEndTime| (periodEndTime - (60 * 60 * 24 * 7)) },
                 THIRTY_DAYS => lambda{ |periodEndTime| (periodEndTime - (60 * 60 * 24 * 30)) },
                 SIXTY_DAYS => lambda{ |periodEndTime| (periodEndTime - (60 * 60 * 24 * 60)) },
                 NINETY_DAYS => lambda{ |periodEndTime| (periodEndTime - (60 * 60 * 24 * 90)) },
                 ONE_HUNDRED_EIGHTY_DAYS => lambda{ |periodEndTime| (periodEndTime - (60 * 60 * 24 * 180)) },
                 YEAR => lambda{ |periodEndTime| (periodEndTime - (60 * 60 * 24 * 365)) }
        }

        @idToNameMap = { MINUTE => "minute",
                         HALF_HOUR => "30 minutes",
                         HOUR => "hour",
                         HALF_DAY => "half day",
                         DAY => "day",
                         THREE_DAYS => "3 days",
                         WEEK => "week",
                         THIRTY_DAYS => "30 days",
                         SIXTY_DAYS => "60 days",
                         NINETY_DAYS => "90 days",
                         ONE_HUNDRED_EIGHTY_DAYS => "180 days",
                         YEAR => "year"
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

    def getName(timePeriod)
        @idToNameMap.fetch(timePeriod)
    end
end
