require 'pubticker_cachers/time_period_constants'
require 'pubticker_cachers/pubticker_cacher'

class ThreeHoursPubtickerCacher < PubtickerCacher
    def updateCache
        writeRatiosToCache('btcusd', 'ltcusd')
    end

    def getTimePeriod
        TimePeriodConstants::THREE_HOURS
    end

end

