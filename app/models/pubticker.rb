require 'net/http'
require 'uri'

class Pubticker < ActiveRecord::Base

    attr_accessor :mid
    attr_accessor :bid
    attr_accessor :ask
    attr_accessor :last_price
    attr_accessor :low
    attr_accessor :high
    attr_accessor :volume
    attr_accessor :timestamp

    attr_accessor :tickerSymbol

    def initialize
        @pubtickerURLFunction = lambda{ "https://api.bitfinex.com/v1/pubticker/" + self.tickerSymbol }

        @jsonResponseFunction = lambda{ 
            uri = URI.parse(@pubtickerURLFunction.call)

            req = Net::HTTP::Get.new uri.to_s

            res = Net::HTTP::start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') { |http|
             http.request req
            }

            JSON.parse res.body
        }

    end

    def pubtickerURLFunction=(func) 
        @pubtickerURLFunction = func
    end

    def jsonResponseFunction=(func)
        @jsonResponseFunction = func
    end

    def populateUsingInternetAPI
        if @tickerSymbol == nil 
            raise ArgumentError
        end

        populate(@jsonResponseFunction.call)
    end

    private
    def populate(responseHash)
        @mid = getHashValueForSymbolKey(:mid, responseHash) 
        @bid = getHashValueForSymbolKey(:bid, responseHash) 
        @ask = getHashValueForSymbolKey(:ask, responseHash) 
        @low = getHashValueForSymbolKey(:low, responseHash) 
        @high = getHashValueForSymbolKey(:high, responseHash) 
        @volume = getHashValueForSymbolKey(:volume, responseHash) 
        @last_price = getHashValueForSymbolKey(:last_price, responseHash) 
        @timestamp = getHashValueForSymbolKey(:timestamp, responseHash) 
        @last_price = getHashValueForSymbolKey(:last_price, responseHash)
    end

    private
    def getHashValueForSymbolKey(sym, h)
        h[sym.to_s]
    end
end
