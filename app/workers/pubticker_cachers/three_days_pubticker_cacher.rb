require 'pubticker_cachers/time_period_constants'
require 'pubticker_cachers/pubticker_cacher'

class ThreeDaysPubtickerCacher < PubtickerCacher
    def updateCache
        writeRatiosToCache(TimePeriodConstants::THREE_DAYS, 'btcusd', 'ltcusd')
    end

end

