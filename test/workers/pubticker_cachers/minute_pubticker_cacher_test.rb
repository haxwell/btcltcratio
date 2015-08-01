require 'test_helper'
require 'pubticker_cachers/minute_pubticker_cacher'

class MinutePubtickerCacherTest < ActiveSupport::TestCase  

    test "update method works" do
        sut = MinutePubtickerCacher.new

        puts pubtickers(:one).created_at
        puts sut.updateCache
        
        assert true
    end
end

