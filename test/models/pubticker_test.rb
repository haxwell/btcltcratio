require 'test_helper'
require 'pubticker'

class PubtickerTest < ActiveSupport::TestCase
    def test_calling_internet_API_without_tickerSymbol_causes_exception
        sut = Pubticker.new

        sut.pubtickerURLFunction = lambda{ "" }
        sut.jsonResponseFunction = lambda{ "" }

        # sut.tickerSymbol = :someSymbol

        begin
            sut.populateUsingInternetAPI
        rescue ArgumentError => ex
            result = :handled
        end

        assert result == :handled
    end
    
    def test_object_returned_from_internet_API_call_is_correct
        sut = Pubticker.new

        # NOTE, TODO: I could not figure out why fixtures would be created,
        # but their values not populated. I did a bunch of reading, and could
        # not see how this was done, so i created a hack method to do it. But,
        # it makes no sense to me, why create fixtures as defined in the
        # test/fixtures/*.yml file, and use the fixture names as defined in the
        # file, but not populate the values as defined?!?!? 7/29/15 10:02 AM
        @temp = populateFixture(:oone) 

        sut.pubtickerURLFunction = lambda{ "" }
        sut.jsonResponseFunction = lambda{ JSON.parse @temp.to_json }
        sut.tickerSymbol = 'btcusd'

        sut.populateUsingInternetAPI

        assert_equal 1.5, sut.bid
        assert_equal 1.5, sut.ask
    end

    def test_can_read_fixture_count_correctly
        assert_equal 2, Pubticker.count
    end

    private
    def populateFixture(sym)
        rtn = pubtickers(sym.to_sym)

        rtn.tickerSymbol = 'btcusd'
        rtn.bid = 1.5
        rtn.ask = 1.5
        rtn.high = 1.5
        rtn.low = 1.5
        rtn.mid = 1.5
        rtn.volume = 1.5
        rtn.last_price = 1.5

        rtn
    end
end
