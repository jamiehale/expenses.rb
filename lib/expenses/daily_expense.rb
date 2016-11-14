module Expenses

  ## An expense that applies every day
  class DailyExpense

    attr_reader :amount, :description

    def initialize( amount, description )
      @amount = amount
      @description = description
    end

    def applies_on?( _ )
      true
    end

    def amount_for( _ )
      @amount
    end

    def ==( other )
      @amount == other.amount && @description == other.description
    end

  end

end
