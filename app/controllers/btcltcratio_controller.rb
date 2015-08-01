class BtcltcratioController < ApplicationController
    def index 
        @btc = JSON.parse Pubticker.where('tickerSymbol' => 'btcusd').order('id desc').limit(1).to_json
        @ltc = JSON.parse Pubticker.where('tickerSymbol' => 'ltcusd').order('id desc').limit(1).to_json

        @btc = @btc[0]
        @ltc = @ltc[0]

        # TODO read from cached database records instead.
        @ratio = @btc['last_price'] / @ltc['last_price']
    end

end
