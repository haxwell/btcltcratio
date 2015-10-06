require 'pubticker_cachers/minute_pubticker_cacher'
require 'pubticker_cachers/half_hour_pubticker_cacher'
require 'pubticker_cachers/hour_pubticker_cacher'
require 'pubticker_cachers/half_day_pubticker_cacher'
require 'pubticker_cachers/day_pubticker_cacher'
require 'pubticker_cachers/three_days_pubticker_cacher'
require 'pubticker_cachers/week_pubticker_cacher'
require 'pubticker_cachers/thirty_days_pubticker_cacher'
require 'pubticker_cachers/sixty_days_pubticker_cacher'
require 'pubticker_cachers/ninety_days_pubticker_cacher'
require 'pubticker_cachers/one_hundred_eighty_days_pubticker_cacher'
require 'pubticker_cachers/year_pubticker_cacher'

class PubtickerCacherList
    def list
        # These must be in order by length of time
            a = [ MinutePubtickerCacher.new,
                HalfHourPubtickerCacher.new, HourPubtickerCacher.new,
                HalfDayPubtickerCacher.new, DayPubtickerCacher.new, ThreeDaysPubtickerCacher.new,
                WeekPubtickerCacher.new, ThirtyDaysPubtickerCacher.new, SixtyDaysPubtickerCacher.new, NinetyDaysPubtickerCacher.new,
                OneHundredEightyDaysPubtickerCacher.new, YearPubtickerCacher.new
            ]

            a
    end
end
