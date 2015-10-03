require 'pubticker_cachers/time_period_constants'
require 'pubticker_cachers/pubticker_cacher'

class ThirtyDaysPubtickerCacher < PubtickerCacher
    def updateCache
        writeRatiosToCache('btcusd', 'ltcusd')
    end

    def getTimePeriod
        TimePeriodConstants::THIRTY_DAYS
    end

end
