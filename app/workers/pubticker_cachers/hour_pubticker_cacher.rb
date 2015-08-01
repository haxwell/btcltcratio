require 'pubticker_cachers/time_period_constants'
require 'pubticker_cachers/pubticker_cacher'

class HourPubtickerCacher < PubtickerCacher
    def updateCache
        writeRatiosToCache(TimePeriodConstants::HOUR, 'btcusd', 'ltcusd')
    end

end

