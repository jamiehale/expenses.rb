module Expenses

  class Configuration

    attr_reader :accounts, :expenses

    def initialize
      @accounts = []
      @expenses = []
    end

    def add_account( account )
      @accounts << account
    end

    def add_expense( expense )
      @expenses << expense
    end

  end

end
