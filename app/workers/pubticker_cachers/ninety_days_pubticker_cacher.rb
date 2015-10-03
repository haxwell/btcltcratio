require 'pubticker_cachers/time_period_constants'
require 'pubticker_cachers/pubticker_cacher'

class NinetyDaysPubtickerCacher < PubtickerCacher
    def updateCache
        writeRatiosToCache('btcusd', 'ltcusd')
    end

    def getTimePeriod
        TimePeriodConstants::NINETY_DAYS
    end

end
