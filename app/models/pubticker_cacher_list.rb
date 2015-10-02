require 'pubticker_cachers/minute_pubticker_cacher'
require 'pubticker_cachers/half_hour_pubticker_cacher'
require 'pubticker_cachers/hour_pubticker_cacher'
require 'pubticker_cachers/half_day_pubticker_cacher'
require 'pubticker_cachers/day_pubticker_cacher'
require 'pubticker_cachers/three_days_pubticker_cacher'
require 'pubticker_cachers/week_pubticker_cacher'

class PubtickerCacherList
    def list
            a = [ MinutePubtickerCacher.new,
                HalfHourPubtickerCacher.new, HourPubtickerCacher.new,
                HalfDayPubtickerCacher.new, DayPubtickerCacher.new, ThreeDaysPubtickerCacher.new,
                WeekPubtickerCacher.new]
            a
    end
end
