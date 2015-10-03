require 'pubticker_cachers/time_period_constants'
require 'pubticker_cachers/pubticker_cacher'

class HalfDayPubtickerCacher < PubtickerCacher
    def updateCache
        writeRatiosToCache('btcusd', 'ltcusd')
    end

    def getTimePeriod
        TimePeriodConstants::HALF_DAY
    end

end
