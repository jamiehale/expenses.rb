module Expenses

  class DailyExpense

    attr_reader :amount, :description

    def initialize( amount, description )
      @amount = amount
      @description = description
    end

    def applies_on?( date )
      true
    end

    def amount_for( date )
      @amount
    end

    def ==( other )
      @amount == other.amount && @description == other.description
    end

  end

end
