require 'pubticker_cachers/time_period_constants'
require 'pubticker_cachers/pubticker_cacher'

class FifteenDaysPubtickerCacher < PubtickerCacher
    def updateCache
        writeRatiosToCache('btcusd', 'ltcusd')
    end

    def getTimePeriod
        TimePeriodConstants::FIFTEEN_DAYS
    end

end

