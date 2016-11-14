module Expenses

  ## Encapsulates the results of the projection
  class ProjectionResults

    attr_reader :days, :account_names

    def initialize( account_names = [] )
      @account_names = account_names
      @days = []
    end

    def add_day( day )
      @days << day
    end

    def each_day( &blk )
      @days.each( &blk )
    end

    def empty?
      @days.empty?
    end

  end

end
