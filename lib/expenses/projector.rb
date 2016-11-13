module Expenses

  class Projector

    def project( from, count, accounts )
      results = ProjectionResults.new( accounts.map {|a| a.name} )
      date = from
      count.times do
        day = ProjectedState.new( date )
        day.add_balance( accounts[ 0 ].balance )
        results.add_day( day )
        date = date.next_day
      end
      results
    end

  end

end
