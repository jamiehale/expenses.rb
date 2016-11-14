require 'spec_helper'

module Expenses

  describe AnnualExpense do

    it 'is creatable with a month, day, amount, and description' do
      expect { AnnualExpense.new( 1, 2, 3.45, 'Annual' ) }.not_to raise_error
    end

    describe 'once created' do

      let( :month ) { 1 }
      let( :day ) { 2 }
      let( :amount ) { 3.45 }
      let( :description ) { 'Annual expense' }
      let( :expense ) { AnnualExpense.new( month, day, amount, description ) }

      it 'knows its month' do
        expect( expense.month ).to eq( month )
      end

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
        expect( expense ).to eq( AnnualExpense.new( month, day, amount, description ) )
      end

      describe 'when testing applicability' do

        it 'is applicable on its day of the year' do
          0.upto( 365 ) do |i|
            date = Date.new( 2016, 1, 1 ) + i
            if date.month == month && date.day == day
              expect( expense.applies_on?( date ) ).to be true
            else
              expect( expense.applies_on?( date ) ).to be false
            end
          end
        end

        it 'has value on its day of the year' do
          0.upto( 365 ) do |i|
            date = Date.new( 2016, 1, 1 ) + i
            if date.month == month && date.day == day
              expect( expense.amount_for( date ) ).to eq( amount )
            else
              expect( expense.amount_for( date ) ).to eq( 0.00 )
            end
          end
        end

      end

    end

  end

end
