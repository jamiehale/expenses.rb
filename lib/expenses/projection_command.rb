module Expenses

  ## Runs balance projection
  class ProjectionCommand

    def initialize( projector = Projector.new, reporter = Reporter.new )
      @projector = projector
      @reporter = reporter
    end

    def run( options, configuration )
      results = @projector.project( start_date( options ), count( options ), configuration.accounts, configuration.expenses )
      @reporter.report( results )
    end

    private

    def start_date( options )
      return Date.parse( options[ 'start' ] ) if options.key? 'start'
      Date.today
    end

    def count( options )
      return options[ 'count' ].to_i if options.key? 'count'
      10
    end

  end

end
