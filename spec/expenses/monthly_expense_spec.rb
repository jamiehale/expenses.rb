require 'spec_helper'

module Expenses

  describe MonthlyExpense do

    it 'is creatable with a day, amount, and description' do
      expect{ MonthlyExpense.new( 1, 2.34, 'Monthly' ) }.not_to raise_error
    end

    describe 'once created' do

      let( :day ) { 1 }
      let( :amount ) { 2.34 }
      let( :description ) { 'Monthly expense' }
      let( :expense ) { MonthlyExpense.new( day, amount, description ) }

      it 'knows its day' do
        expect( expense.day ).to eq( day )
      end

      it 'knows its amount' do
        expect( expense.amount ).to eq( amount )
      end

      it 'knows its description' do
        expect( expense.description ).to eq( description )
      end

      it 'handles equality' do
        expect( expense ).to eq( MonthlyExpense.new( day, amount, description ) )
      end

      describe 'when testing applicability' do

        it 'is applicable on its day of the month' do
          1.upto( 12 ) do |i|
            expect( expense.applies_on?( Date.new( 2016, i, 1 ) ) ).to be true
          end
        end

        it 'is not applicable on any other day of the month' do
          1.upto( 30 ) do |i|
            expect( expense.applies_on?( Date.new( 2016, 1, i ) ) ).to be false unless i == day
          end
        end

      end

    end

  end

end
