require 'pubticker_cachers/time_period_constants'
require 'pubticker_cachers/pubticker_cacher'

class ThirtyDaysPubtickerCacher < PubtickerCacher
    def updateCache
        writeRatiosToCache(TimePeriodConstants::THIRTY_DAYS, 'btcusd', 'ltcusd')
    end

end

