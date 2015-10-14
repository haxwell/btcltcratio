require 'net/http'
require 'uri'

class PubtickerReader

    def initialize
        @pubtickerURLFunction = lambda do |tickerSymbol| 
            "https://api.bitfinex.com/v1/pubticker/" + tickerSymbol 
        end

        @jsonResponseFunction = lambda do |tickerSymbol| 
            uri = URI.parse(@pubtickerURLFunction.call(tickerSymbol))

            req = Net::HTTP::Get.new uri.to_s

            res = Net::HTTP::start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') { |http|
             http.request req
            }

            rtn = JSON.parse res.body
            rtn.merge({:tickerSymbol => tickerSymbol})
        end
    end

    def pubtickerURLFunction=(func) 
        @pubtickerURLFunction = func
    end

    def jsonResponseFunction=(func)
        @jsonResponseFunction = func
    end

    def read(tickerSymbol)
        @jsonResponseFunction.call(tickerSymbol)
    end
end
