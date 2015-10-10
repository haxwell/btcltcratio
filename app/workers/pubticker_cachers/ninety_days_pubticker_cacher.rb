require 'btcratio/constants/time_period_constants'
require './app/workers/pubticker_cachers/pubticker_cacher'

class NinetyDaysPubtickerCacher < PubtickerCacher
    def updateCache
        writeRatiosToCache('btcusd', 'ltcusd')
    end

    def getTimePeriod
        TimePeriodConstants::NINETY_DAYS
    end

end
