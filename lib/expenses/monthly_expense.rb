module Expenses

  ## Expense that applies on the same day every month
  class MonthlyExpense

    attr_reader :day, :amount, :description

    def initialize( day, amount, description )
      @day = day
      @amount = amount
      @description = description
    end

    def applies_on?( date )
      return date.day == Date.new( date.year, date.month, @day ).day if @day < 0
      date.day == @day
    end

    def amount_for( date )
      return @amount if applies_on?( date )
      0.00
    end

    def ==( other )
      @day == other.day && @amount == other.amount && @description == other.description
    end

  end

end
