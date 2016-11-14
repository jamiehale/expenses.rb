module Expenses

  ## Expense that applies on the same day every year
  class AnnualExpense

    attr_reader :month, :day, :amount, :description

    def initialize( month, day, amount, description )
      @month = month
      @day = day
      @amount = amount
      @description = description
    end

    def applies_on?( date )
      date.month == @month && date.day == @day
    end

    def amount_for( date )
      return @amount if applies_on?( date )
      0.00
    end

    def ==( other )
      @month == other.month && @day == other.day && @amount == other.amount && @description == other.description
    end

  end

end
