module Expenses

  class Projector

    def project( from, count, accounts, expenses )
      results = ProjectionResults.new( accounts.map {|a| a.name} )
      balances = accounts.map {|a| a.balance}
      date = from
      count.times do
        notes = []
        expenses.each do |expense|
          if expense.applies_on?( date )
            balances[ 0 ] -= expense.amount_for( date )
            notes << expense.description
          end
        end
        results.add_day( ProjectedState.new( date, balances.dup ) )
        date = date.next_day
      end
      results
    end

  end

end
