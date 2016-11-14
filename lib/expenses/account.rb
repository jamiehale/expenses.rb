module Expenses

  ## Encapsulates an account name and balance
  class Account

    attr_accessor :name, :balance

    def initialize( name = nil, balance = 0.00 )
      @name = name
      @balance = balance
    end

    def ==(other)
      @name == other.name && @balance == other.balance
    end

  end

end
