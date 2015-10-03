require 'pubticker_cachers/time_period_constants'

class BtcltcratioController < ApplicationController
    def index 
        # Get the most recent pubticker value from the DB
        @btc = JSON.parse Pubticker.where('tickerSymbol' => 'btcusd').order('id desc').limit(1).to_json
        @ltc = JSON.parse Pubticker.where('tickerSymbol' => 'ltcusd').order('id desc').limit(1).to_json
        @old = JSON.parse Pubticker.order('id asc').limit(1).to_json

        @btc = @btc[0]
        @ltc = @ltc[0]
        @old = @old[0]

        @ratio = @btc['last_price'] / @ltc['last_price']

        rtn = []

        list = PubtickerCacherList.new.list
        list.each { |pc| cpt = getCachedPubticker(pc.getTimePeriod()); puts cpt.to_s; cpt == nil ? nil : rtn.push(cpt); }

        @ratios = rtn;
    end

    def getCachedPubticker(timeperiod, tickerSymbolA = 'btcusd', tickerSymbolB = 'ltcusd')
        rtn = nil

        v = JSON.parse CachedPubticker.where(:timeperiod => timeperiod, :ticker_symbol_a => tickerSymbolA, :ticker_symbol_b => tickerSymbolB).to_json

        if v != nil && v.size > 0
            rtn = v[0]
            rtn = rtn.merge({"title" => TimePeriodConstants.new.getName(timeperiod)})
        else
            puts "getCachedPubticker couldn't find a cached record for timePeriod " + timeperiod.to_s
        end

        rtn
    end

end
