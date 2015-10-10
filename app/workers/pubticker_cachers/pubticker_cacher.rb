require './app/workers/pubticker_cachers/period_ratio_calculator'
require 'btcratio/models/pubticker'

class PubtickerCacher

    private
    def isSufficientPubtickerDataAvailable(timePeriod)
        cnt = 0
        times = getPeriodBeginAndEndTime(timePeriod)

        if times[0] != nil && times[1] != nil
            cnt = Pubticker.where("created_at <= ?", times[0].to_s.sub(" UTC", "")).count
            puts "-- isSufficientPubtickerDataAvailable(" + timePeriod.to_s + ") is returning " + (cnt > 0).to_s
        end

        cnt > 0
    end

    #private
    ## TODO this is a utility method.. should be in its own namespace
    def getPeriodBeginAndEndTime(timePeriod)
        periodEndTime = nil
        periodBeginTime = nil

        #get the most recent row
        aa = JSON.parse Pubticker.order('created_at desc').limit(1).to_json
        aa = aa[0]

        if aa.size > 0
            periodEndTime = DateTime.parse(aa['created_at']).to_time.utc

            #get the rows previous to it that cover the time period
            periodBeginTime = TimePeriodConstants.new.getBeginDate(timePeriod, periodEndTime)
        end

        [periodBeginTime, periodEndTime]
    end

    private
    def writeRatiosToCache(tickerSymbolA, tickerSymbolB)
        timePeriod = getTimePeriod()
        v = nil

        if isSufficientPubtickerDataAvailable(timePeriod)
            v = CachedPubticker.find_by(:timeperiod => timePeriod)
            ratio = getAverageLowAndHighRatios(timePeriod, tickerSymbolA, tickerSymbolB) 

            (v == nil) ? v = CachedPubticker.new(ratio) : v.update(ratio)

            v.save
        end

        v
    end

    private
    def getAverageLowAndHighRatios(timePeriod, tickerSymbolA, tickerSymbolB)

        times = getPeriodBeginAndEndTime(timePeriod)

        periodBeginTime = times[0] + 0;
        periodEndTime = times[1] + 1;

        b = Pubticker.where(created_at: (periodBeginTime.to_s.sub(" UTC", ""))..(periodEndTime.to_s.sub(" UTC", ""))).order('created_at desc')
        ba = b.to_a

        puts "Query returned " + ba.size.to_s + " rows."

        ba1 = ba.select { |x| x.tickerSymbol == tickerSymbolA }
        ba2 = ba.select { |x| x.tickerSymbol == tickerSymbolB }

        # ensure arrays are the same size
        unless ba1.size == ba2.size 
            raise ArgumentError, "hmmm. something abnormal happened; the tickersymbol lists should be the same size"
        end

        # send arrays of pubticker objects to calculator
        calc = PeriodRatioCalculator.new
        open = calc.calculateOpenRatio(ba1, ba2)
        close = calc.calculateCloseRatio(ba1, ba2)
        delta = calc.calculateOpenAndCloseDelta(open, close)

        ratios = calc.calculatePeriodRatios(ba1, ba2)

        # add some extra columns
        ratios = ratios.merge({:ticker_symbol_a => tickerSymbolA, :ticker_symbol_b => tickerSymbolB, :period_begin => periodBeginTime.to_f, :period_end => periodEndTime.to_f, :timeperiod => timePeriod, :open => open, :close => close, :delta => delta[0], :delta_percentage => delta[1]})

        puts "Calculated Ratios: " + ratios.to_s

        ratios
    end

    def getTimePeriod
        -1
    end

end
