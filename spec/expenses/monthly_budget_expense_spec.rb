require 'spec_helper'

module Expenses

  describe MonthlyBudgetExpense do

    it 'is creatable with an amount and a description' do
      expect { MonthlyBudgetExpense.new( 100.00, 'Monthly budget' ) }.not_to raise_error
    end

    describe 'once created' do

      let( :amount ) { 300.00 }
      let( :description ) { 'Monthly budget amount' }
      let( :expense ) { MonthlyBudgetExpense.new( amount, description ) }

      it 'knows its amount' do
        expect( expense.amount ).to eq( amount )
      end

      it 'knows its description' do
        expect( expense.description ).to eq( description )
      end

      it 'handles equality' do
        expect( expense ).to eq( MonthlyBudgetExpense.new( amount, description ) )
      end

      describe 'when testing applicability' do

        it 'applies every day' do
          1.upto( 30 ) do |i|
            expect( expense.applies_on?( Date.new( 2016, 11, i ) ) ).to be true
          end
        end

        it 'has a fractional value every day' do
          1.upto( 30 ) do |i|
            expect( expense.amount_for( Date.new( 2016, 11, i ) ) ).to eq( amount / 30 )
          end
        end

      end

    end

  end

end
