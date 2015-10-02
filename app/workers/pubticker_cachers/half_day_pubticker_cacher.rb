require 'pubticker_cachers/time_period_constants'
require 'pubticker_cachers/pubticker_cacher'

class HalfDayPubtickerCacher < PubtickerCacher
    def updateCache
        writeRatiosToCache(TimePeriodConstants::HALF_DAY, 'btcusd', 'ltcusd')
    end

end

