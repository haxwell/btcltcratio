class HourPubtickerCacher < Pubticker_Cacher
    def updateCache
        tsA = 'btcusd'
        tsB = 'ltcusd'

        btc = getObject(tsA)
        ltc = getObject(tsB)
        ratio = getAverageLowAndHighRatios(TimePeriodConstants::HOUR, tsA, tsB)

        out = tsA + " " + tsB + " " + ratio[:high] + " " + ratio[:low] + " " + ratio[:avg] + " " + "PERIODBEGIN" + " " + "PERIODEND" + TimePeriodConstants::HOUR

    end


    def getObject(tickerSymbol)
        v = Pubticker.where('tickerSymbol' => tickerSymbol).order('id desc').limit(1)
        v.to_a 
    end

end
