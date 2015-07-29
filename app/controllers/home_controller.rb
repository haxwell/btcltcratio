class HomeController < ApplicationController
  def show
      @number1 = 15
      @number2 = 3.4
      @ratio = @number1 / @number2
  end
end
