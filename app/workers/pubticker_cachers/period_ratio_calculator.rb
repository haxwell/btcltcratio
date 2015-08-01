class PeriodRatioCalculator

    def calculate(pubtickerArrayA, pubtickerArrayB)
        unless pubtickerArrayA.size == pubtickerArrayB.size 
            raise ArgumentError, "List of currency tickers needs to be equal lengths." 
        end

        unless pubtickerArrayA.size > 0 
            raise ArgumentError, "List of currency tickers must have at least one item." 
        end
        
        #generate a ratio for each pair
        arr = [];
        cnt = pubtickerArrayA.size

        cnt.times { |i| arr << (pubtickerArrayA[i].last_price / pubtickerArrayB[i].last_price) }

        #add all the ratios up and divide by their number
        sum = 0; arr.each { |x| sum += x; }
        avg = sum / arr.size;

        # find the high and low ratio for the period
        low = 0; high = 0; arr.each {|x| (x > high) ? high = x : nil; (x < low) ? low = x : nil; }

        #return it all
        {:high => high, :low => low, :avg => avg}
    end
end

