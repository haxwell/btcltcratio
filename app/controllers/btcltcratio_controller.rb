require 'pubticker_cachers/time_period_constants'

class BtcltcratioController < ApplicationController
    def index 
        # Get the most recent pubticker value from the DB
        @btc = JSON.parse Pubticker.where('tickerSymbol' => 'btcusd').order('id desc').limit(1).to_json
        @ltc = JSON.parse Pubticker.where('tickerSymbol' => 'ltcusd').order('id desc').limit(1).to_json

        @btc = @btc[0]
        @ltc = @ltc[0]

        # TODO read from cached database records instead.
        @ratio = @btc['last_price'] / @ltc['last_price']

        @ratio_minute = getCachedPubticker(TimePeriodConstants::MINUTE)
        @ratio_hour = getCachedPubticker(TimePeriodConstants::HOUR)
        @ratio_half_hour = getCachedPubticker(TimePeriodConstants::HALF_HOUR)
        @ratio_half_day = getCachedPubticker(TimePeriodConstants::HALF_DAY)
        @ratio_day = getCachedPubticker(TimePeriodConstants::DAY)
    end

    def getCachedPubticker(timeperiod, tickerSymbolA = 'btcusd', tickerSymbolB = 'ltcusd')
        v = JSON.parse CachedPubticker.where(:timeperiod => timeperiod, :ticker_symbol_a => tickerSymbolA, :ticker_symbol_b => tickerSymbolB).to_json

        puts v[0]

        v[0]
    end

end
