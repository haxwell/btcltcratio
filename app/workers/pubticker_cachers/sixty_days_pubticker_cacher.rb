require 'pubticker_cachers/time_period_constants'
require 'pubticker_cachers/pubticker_cacher'

class SixtyDaysPubtickerCacher < PubtickerCacher
    def updateCache
        writeRatiosToCache('btcusd', 'ltcusd')
    end

    def getTimePeriod
        TimePeriodConstants::SIXTY_DAYS
    end

end
