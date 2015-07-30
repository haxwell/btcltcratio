class BtcltcratioController < ApplicationController
    def index
      @btc = Pubticker.new
      @btc.tickerSymbol = "btcusd"
      @btc.populateUsingInternetAPI

      @ltc = Pubticker.new
      @ltc.tickerSymbol = "ltcusd"
      @ltc.populateUsingInternetAPI

      @ratio = @btc.last_price.to_f / @ltc.last_price.to_f

      @btc.save
      @ltc.save
    end

  def show
  end
end
