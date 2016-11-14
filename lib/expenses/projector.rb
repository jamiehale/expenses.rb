module Expenses

  ## Projects expenses
  class Projector

    def project( from, count, accounts, expenses )
      results = ProjectionResults.new( accounts.map( &:name ) )
      balances = accounts.map( &:balance )
      date = from
      count.times do
        apply_expenses( expenses, balances, date, results )
        date = date.next_day
      end
      results
    end

    private

    def apply_expenses( expenses, balances, date, results )
      notes = []
      expenses.each do |expense|
        if expense.applies_on?( date )
          balances[ 0 ] -= expense.amount_for( date )
          notes << expense.description
        end
      end
      results.add_day( ProjectedState.new( date, balances.dup ) )
    end

  end

end
