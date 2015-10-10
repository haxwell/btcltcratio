require 'btcratio/constants/time_period_constants'
require './app/workers/pubticker_cachers/pubticker_cacher'

class SixtyDaysPubtickerCacher < PubtickerCacher
    def updateCache
        writeRatiosToCache('btcusd', 'ltcusd')
    end

    def getTimePeriod
        TimePeriodConstants::SIXTY_DAYS
    end

end
