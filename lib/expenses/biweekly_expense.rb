module Expenses

  ## Expense that happens once every 2 weeks
  class BiWeeklyExpense

    attr_reader :date, :amount, :description

    def initialize( date, amount, description )
      @date = date
      @amount = amount
      @description = description
    end

    def applies_on?( date )
      ( ( date - @date ).abs % 14 ).zero?
    end

    def amount_for( date )
      return @amount if applies_on?( date )
      0.00
    end

    def ==( other )
      @date == other.date && @amount == other.amount && @description == other.description
    end

  end

end
