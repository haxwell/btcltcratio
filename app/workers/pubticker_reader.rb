require 'net/http'
require 'uri'

class PubtickerReader

    def initialize(tickerSymbol)
        @pubtickerURLFunction = lambda{ "https://api.bitfinex.com/v1/pubticker/" + tickerSymbol }

        @jsonResponseFunction = lambda{ 
            uri = URI.parse(@pubtickerURLFunction.call)

            req = Net::HTTP::Get.new uri.to_s

            res = Net::HTTP::start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') { |http|
             http.request req
            }

            rtn = JSON.parse res.body
            rtn.merge({:tickerSymbol => tickerSymbol})
        }
    end

    def pubtickerURLFunction=(func) 
        @pubtickerURLFunction = func
    end

    def jsonResponseFunction=(func)
        @jsonResponseFunction = func
    end

    def read
        @jsonResponseFunction.call
    end
end
