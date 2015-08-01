require 'pubticker_cachers/time_period_constants'
require 'pubticker_cachers/pubticker_cacher'

class MinutePubtickerCacher < PubtickerCacher
    def updateCache
        tsA = 'btcusd'
        tsB = 'ltcusd'

        btc = getObject(tsA)
        ltc = getObject(tsB)
        ratio = getAverageLowAndHighRatios(TimePeriodConstants::MINUTE, tsA, tsB)

        out = tsA + " " + tsB + " " + ratio[:high].to_s  + " " + ratio[:low].to_s  + " " + ratio[:avg].to_s  + " " + "PERIODBEGIN" + " " + "PERIODEND" + TimePeriodConstants::MINUTE.to_s
    end

    private
    def getObject(tickerSymbol)
        v = Pubticker.where('tickerSymbol' => tickerSymbol).order('id desc').limit(1)
        v.to_a 
    end

end

