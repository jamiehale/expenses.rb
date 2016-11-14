require 'spec_helper'

module Expenses

  describe AnnualBudgetExpense do

    it 'is creatable with an amount and a description' do
      expect { AnnualBudgetExpense.new( 100.00, 'Annual budget' ) }.not_to raise_error
    end

    describe 'once created' do

      let( :amount ) { 365.00 }
      let( :description ) { 'Annual budget amount' }
      let( :expense ) { AnnualBudgetExpense.new( amount, description ) }

      it 'knows its amount' do
        expect( expense.amount ).to eq( amount )
      end

      it 'knows its description' do
        expect( expense.description ).to eq( description )
      end

      it 'handles equality' do
        expect( expense ).to eq( AnnualBudgetExpense.new( amount, description ) )
      end

      describe 'when testing applicability' do

        it 'applies every day' do
          1.upto( 30 ) do |i|
            expect( expense.applies_on?( Date.new( 2016, 11, i ) ) ).to be true
          end
        end

        it 'has a fractional value every day' do
          1.upto( 30 ) do |i|
            expect( expense.amount_for( Date.new( 2016, 11, i ) ) ).to eq( amount / 365 )
          end
        end

      end

    end

  end

end
