require 'test_helper'
require 'pubticker_cachers/period_ratio_calculator'

class PeriodRatioCalculatorTest < ActiveSupport::TestCase
    test "expect exception if currency ticker lists are not equal lengths" do
        sut = PeriodRatioCalculator.new

        caughtException = false;

        begin
            sut.calculate(["foo"], [])
        rescue ArgumentError => ex
            caughtException = true;
        end

        assert caughtException

        begin
            sut.calculate([], ["foo"])
        rescue ArgumentError => ex
            caughtException = true;
        end

        assert caughtException
    end

    test "with single row the expected ratio is returned" do
        a = Pubticker.new
        b = Pubticker.new

        a.last_price = 100
        b.last_price = 10

        sut = PeriodRatioCalculator.new

        v = sut.calculate([a], [b])

        puts v

        assert_equal v[:avg], 10
    end

    test "with three rows the expected ratio is returned" do
        a = Array.new
        b = Array.new

        3.times do  |x| btc = Pubticker.new; ltc = Pubticker.new; 
                      btc.last_price = 100; ltc.last_price = 10; 
                        a << btc; b << ltc; 
        end

        sut = PeriodRatioCalculator.new
        
        v = sut.calculate(a, b)

        assert_equal v[:avg], 10
    end

end
