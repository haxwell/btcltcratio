require 'net/http'
require 'uri'

class Pubticker < ActiveRecord::Base

    def initialize
        super()
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
        if self.tickerSymbol == nil 
            raise ArgumentError, "The 'tickerSymbol' attribute has not been set"
        end

        populate(@jsonResponseFunction.call)
    end

    private
    def populate(responseHash)
        self.mid = getHashValueForSymbolKey(:mid, responseHash) 
        self.bid = getHashValueForSymbolKey(:bid, responseHash) 
        self.ask = getHashValueForSymbolKey(:ask, responseHash) 
        self.low = getHashValueForSymbolKey(:low, responseHash) 
        self.high = getHashValueForSymbolKey(:high, responseHash) 
        self.volume = getHashValueForSymbolKey(:volume, responseHash) 
        self.last_price = getHashValueForSymbolKey(:last_price, responseHash) 
        self.timestamp = getHashValueForSymbolKey(:timestamp, responseHash) 
        self.last_price = getHashValueForSymbolKey(:last_price, responseHash)
    end

    private
    def getHashValueForSymbolKey(sym, h)
        h[sym.to_s]
    end
end
