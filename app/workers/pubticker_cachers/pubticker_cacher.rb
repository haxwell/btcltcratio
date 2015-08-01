require 'pubticker_cachers/period_ratio_calculator'

class PubtickerCacher

    private
    def getAverageLowAndHighRatios(timePeriod, tickerSymbolA, tickerSymbolB)
        # NOTE this all works because I assume that the created_at date of the newest row is 
        # the closest approximation I can get of when the database was last updated.

        #get the most recent row
        a = Pubticker.order('timestamp desc').limit(1).to_json

        #using its created by timestamp
        aa = JSON.parse a
        aa = aa[0]
        periodEndDate = Time.at(aa['timestamp']).to_datetime

        #get the rows previous to it that cover the time period
        periodBeginDate = TimePeriodConstants.new.getBeginDate(timePeriod, periodEndDate)

        b = Pubticker.where(timestamp: (periodBeginDate.to_f)..(periodEndDate.to_f)).order('timestamp desc')
        ba = b.to_a

        ba1 = ba.select { |x| x.tickerSymbol == tickerSymbolA }        
        ba2 = ba.select { |x| x.tickerSymbol == tickerSymbolB }        

        # ensure arrays are the same size
        unless ba1.size == ba2.size 
            raise ArgumentError, "hmmm. something abnormal happened; the tickersymbol lists should be the same size"
        end

        # send arrays of pubticker objects to calculator
        ratios = PeriodRatioCalculator.new.calculate(ba1, ba2)
    end

end
