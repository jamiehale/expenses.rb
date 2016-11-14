module Expenses

  ## Encapsulates a set of balances one a day
  class ProjectedState

    attr_reader :date, :balances

    def initialize( date = Date.today, balances = [] )
      @date = date
      @balances = balances
    end

    def add_balance( balance )
      @balances << balance
    end

    def to_csv
      @date.to_s + ',' + @balances.map { |b| format( '%.2f', b ) }.join( ',' )
    end

  end

end
