require 'spec_helper'

module Expenses

  describe DailyExpense do

    it 'is creatable with an amount and a description' do
      expect{ DailyExpense.new( 5.00, 'daily' ) }.not_to raise_error
    end

    describe 'once created' do

      let( :amount ) { 1.00 }
      let( :description ) { 'daily' }
      let( :expense ) { DailyExpense.new( amount, description ) }

      it 'knows its amount' do
        expect( expense.amount ).to eq( amount )
      end

      it 'knows its description' do
        expect( expense.description ).to eq( description )
      end

      describe 'when determining applicability' do

        it 'is applicable today' do
          expect( expense.applies_on?( Date.today ) ).to be true
        end

        it 'has value today' do
          expect( expense.amount_for( Date.today ) ).to eq( amount )
        end

        it 'is applicable 100 years ago' do
          expect( expense.applies_on?( Date.new( 1916, 5, 30 ) ) ).to be true
        end

        it 'has value 100 years ago' do
          expect( expense.amount_for( Date.new( 1916, 5, 30 ) ) ).to eq( amount )
        end

        it 'is applicable in the future' do
          expect( expense.applies_on?( Date.new( 2543, 1, 1 ) ) ).to be true
        end

        it 'has value in the future' do
          expect( expense.amount_for( Date.new( 2543, 1, 1 ) ) ).to eq( amount )
        end

      end

    end

  end

end
