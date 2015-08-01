require 'pubticker_cachers/time_period_constants'
require 'pubticker_cachers/pubticker_cacher'

class HourPubtickerCacher < Pubticker_Cacher
    def updateCache
        tsA = 'btcusd'
        tsB = 'ltcusd'

        ratio = getAverageLowAndHighRatios(TimePeriodConstants::HOUR, tsA, tsB)

        out = tsA + " " + tsB + " " + ratio[:high].to_s  + " " + ratio[:low].to_s  + " " + ratio[:avg].to_s  + " " + ratio[:period_begin].to_s + " " + ratio[:period_end].to_s + TimePeriodConstants::HOUR.to_s
    end

end
