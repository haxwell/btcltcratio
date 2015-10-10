require 'btcratio/constants/time_period_constants'
require './app/workers/pubticker_cachers/pubticker_cacher'

class DayPubtickerCacher < PubtickerCacher
    def updateCache
        writeRatiosToCache('btcusd', 'ltcusd')
    end

    def getTimePeriod
        TimePeriodConstants::DAY
    end

end
