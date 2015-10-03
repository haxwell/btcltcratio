require 'pubticker_cachers/time_period_constants'
require 'pubticker_cachers/pubticker_cacher'

class MinutePubtickerCacher < PubtickerCacher
    def updateCache
        writeRatiosToCache(TimePeriodConstants::MINUTE, 'btcusd', 'ltcusd')
    end

end

