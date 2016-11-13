module Expenses

  class AccountBalance

    attr_reader :name
    attr_accessor :balance

    def initialize( name, balance = 0.00 )
      @name = name
      @balance = balance
    end

  end

end
