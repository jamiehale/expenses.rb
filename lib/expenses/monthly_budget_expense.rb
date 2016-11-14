module Expenses

  ## An expense that applies a monthly amount spread across every day
  class MonthlyBudgetExpense

    attr_reader :amount, :description

    def initialize( amount, description )
      @amount = amount
      @description = description
    end

    def applies_on?( _ )
      true
    end

    def amount_for( date )
      @amount / days_in_month( date.year, date.month )
    end

    def ==( other )
      @amount == other.amount && @description == other.description
    end

    private

    def days_in_month( year, month )
      Date.new( year, month, -1 ).day
    end

  end

end
