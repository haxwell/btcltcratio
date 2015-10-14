require './app/workers/pubticker_cachers/minute_pubticker_cacher'
require './app/workers/pubticker_cachers/half_hour_pubticker_cacher'
require './app/workers/pubticker_cachers/hour_pubticker_cacher'
require './app/workers/pubticker_cachers/three_hours_pubticker_cacher'
require './app/workers/pubticker_cachers/six_hours_pubticker_cacher'
require './app/workers/pubticker_cachers/half_day_pubticker_cacher'
require './app/workers/pubticker_cachers/day_pubticker_cacher'
require './app/workers/pubticker_cachers/three_days_pubticker_cacher'
require './app/workers/pubticker_cachers/week_pubticker_cacher'
require './app/workers/pubticker_cachers/fifteen_days_pubticker_cacher'
require './app/workers/pubticker_cachers/thirty_days_pubticker_cacher'
require './app/workers/pubticker_cachers/sixty_days_pubticker_cacher'
require './app/workers/pubticker_cachers/ninety_days_pubticker_cacher'
require './app/workers/pubticker_cachers/one_hundred_eighty_days_pubticker_cacher'
require './app/workers/pubticker_cachers/year_pubticker_cacher'

class PubtickerCacherList
    @@minute = MinutePubtickerCacher.new

                @@halfHour = HalfHourPubtickerCacher.new
                @@hour = HourPubtickerCacher.new
                @@threeHours = ThreeHoursPubtickerCacher.new
                @@sixHours = SixHoursPubtickerCacher.new
                @@halfDay = HalfDayPubtickerCacher.new
                @@day = DayPubtickerCacher.new
                @@threeDays = ThreeDaysPubtickerCacher.new
                @@week = WeekPubtickerCacher.new
                @@fifteenDays = FifteenDaysPubtickerCacher.new
                @@thirtyDays = ThirtyDaysPubtickerCacher.new
                @@sixtyDays = SixtyDaysPubtickerCacher.new
                @@ninetyDays = NinetyDaysPubtickerCacher.new
                @@oneHundredEightyDays = OneHundredEightyDaysPubtickerCacher.new
                @@year = YearPubtickerCacher.new


    def self.list
        # These must be in order by length of time
            a = [ @@minute,
                  @@halfHour,
                  @@threeHours,
                  @@sixHours,
                  @@halfDay,
                  @@day,
                  @@threeDays,
                  @@week,
                  @@fifteenDays,
                  @@thirtyDays,
                  @@sixtyDays,
                  @@ninetyDays,
                  @@oneHundredEightyDays,
                  @@year
            ]

            a
    end
end
