module Expenses

  ## An expense that applies an annual amount spread across every day
  class AnnualBudgetExpense

    attr_reader :amount, :description

    def initialize( amount, description )
      @amount = amount
      @description = description
    end

    def applies_on?( _ )
      true
    end

    def amount_for( date )
      @amount / 365
    end

    def ==( other )
      @amount == other.amount && @description == other.description
    end

  end

end
