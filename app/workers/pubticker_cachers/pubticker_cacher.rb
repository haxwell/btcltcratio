require 'pubticker_cachers/period_ratio_calculator'

class PubtickerCacher

    private
    def writeRatiosToCache(timePeriod, tickerSymbolA, tickerSymbolB)
        puts "checking for cached timeperiod " + timePeriod.to_s
        v = CachedPubticker.find_by(:timeperiod => timePeriod)

        (v == nil) ? (puts "No cached records for timeperiod " + timePeriod.to_s) : (puts "Found cached records for timeperiod " + timePeriod.to_s)

        puts "2 WriteRatiosToCache for timePeriod = " + timePeriod.to_s
        ratio = getAverageLowAndHighRatios(timePeriod, tickerSymbolA, tickerSymbolB) 

        (v == nil) ? v = CachedPubticker.new(ratio) : v.update(ratio)

        v.save
        v
    end

    private
    def getAverageLowAndHighRatios(timePeriod, tickerSymbolA, tickerSymbolB)

        #get the most recent row
        a = Pubticker.order('created_at desc').limit(1).to_json

        #puts "--> " + a.to_s
        
        aa = JSON.parse a
        aa = aa[0]
        periodEndTime = DateTime.parse(aa['created_at']).to_time.utc

        #puts "periodEndTime: " + periodEndTime.to_s

        #get the rows previous to it that cover the time period
        periodBeginTime = TimePeriodConstants.new.getBeginDate(timePeriod, periodEndTime)

        #puts "periodBeginTime: " + periodBeginTime.to_s
        #puts "periodEndTime: " + periodEndTime.to_s

        periodEndTime = periodEndTime + 1;

        b = Pubticker.where(created_at: (periodBeginTime.to_s.sub(" UTC", ""))..(periodEndTime.to_s.sub(" UTC", ""))).order('created_at desc')
        ba = b.to_a

        puts "Query returned " + ba.size.to_s + " rows."

        ba1 = ba.select { |x| x.tickerSymbol == tickerSymbolA }
        ba2 = ba.select { |x| x.tickerSymbol == tickerSymbolB }

        #puts "tickerSymbolA size = " + ba1.size.to_s
        #puts "tickerSymbolB size = " + ba2.size.to_s

        # ensure arrays are the same size
        unless ba1.size == ba2.size 
            raise ArgumentError, "hmmm. something abnormal happened; the tickersymbol lists should be the same size"
        end

        # send arrays of pubticker objects to calculator
        ratios = PeriodRatioCalculator.new.calculate(ba1, ba2)

        puts "Calculated Ratios: " + ratios.to_s

        # add some extra columns
        ratios = ratios.merge({:ticker_symbol_a => tickerSymbolA, :ticker_symbol_b => tickerSymbolB, :period_begin => periodBeginTime.to_f, :period_end => periodEndTime.to_f, :timeperiod => timePeriod})
    end

end
