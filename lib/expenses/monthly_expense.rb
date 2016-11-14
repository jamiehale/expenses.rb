module Expenses

  class MonthlyExpense

    attr_reader :day, :amount, :description

    def initialize( day, amount, description )
      @day = day
      @amount = amount
      @description = description
    end

    def applies_on?( date )
      date.day == @day
    end

    def ==( other )
      @day == other.day && @amount == other.amount && @description == other.description
    end

  end

end
