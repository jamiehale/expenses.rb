module Expenses

  class OneTimeExpense

    attr_reader :date, :amount, :description

    def initialize( date, amount, description )
      @date = date
      @amount = amount
      @description = description
    end

    def applies_on?( date )
      @date == date
    end

    def ==(other)
      @date == other.date && @amount == other.amount && @description == other.description
    end

  end

end
