require 'pubticker_cachers/time_period_constants'
require 'pubticker_cachers/pubticker_cacher'

class OneHundredEightyDaysPubtickerCacher < PubtickerCacher
    def updateCache
        writeRatiosToCache('btcusd', 'ltcusd')
    end

    def getTimePeriod
        TimePeriodConstants::ONE_HUNDRED_EIGHTY_DAYS
    end

end
