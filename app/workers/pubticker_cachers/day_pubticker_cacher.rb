require 'pubticker_cachers/time_period_constants'
require 'pubticker_cachers/pubticker_cacher'

class DayPubtickerCacher < PubtickerCacher
    def updateCache
        writeRatiosToCache(TimePeriodConstants::DAY, 'btcusd', 'ltcusd')
    end

end

