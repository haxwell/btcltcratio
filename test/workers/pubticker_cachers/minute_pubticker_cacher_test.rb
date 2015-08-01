require 'test_helper'
require 'pubticker_cachers/minute_pubticker_cacher'

class MinutePubtickerCacherTest < ActiveSupport::TestCase  

    test "update method works" do
        sut = MinutePubtickerCacher.new

        v = sut.updateCache

        # TODO do some better checking here.
        assert v.avg == 10
    end
end

