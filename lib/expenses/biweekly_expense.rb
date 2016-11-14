module Expenses

  class BiWeeklyExpense

    attr_reader :date, :amount, :description

    def initialize( date, amount, description )
      @date = date
      @amount = amount
      @description = description
    end

    def applies_on?( date )
      ( date - @date ).abs % 14 == 0
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
