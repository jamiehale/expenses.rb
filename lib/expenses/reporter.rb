module Expenses

  class Reporter

    def initialize( stream = STDOUT )
      @stream = stream
    end

    def report( projection )
      return if projection.empty?
      write_header( projection )
      projection.each_day do |day|
        @stream.puts day.to_csv
      end
    end

    private

    def write_header( projection )
      @stream.puts 'Date,' + projection.account_names.join( ',' )
    end

  end

end
