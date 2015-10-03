require 'pubticker_cachers/time_period_constants'
require 'pubticker_cachers/pubticker_cacher'

class ThreeDaysPubtickerCacher < PubtickerCacher
    def updateCache
        writeRatiosToCache('btcusd', 'ltcusd')
    end

    def getTimePeriod
        TimePeriodConstants::THREE_DAYS
    end

end
