require 'pubticker_cachers/time_period_constants'
require 'pubticker_cachers/pubticker_cacher'

class HalfHourPubtickerCacher < PubtickerCacher
    def updateCache
        writeRatiosToCache(TimePeriodConstants::HALF_HOUR, 'btcusd', 'ltcusd')
    end

end

