require 'spec_helper'

module Expenses

  describe WeeklyExpense do

    it 'is creatable with a date, an amount, and a description' do
      expect { WeeklyExpense.new( Date.new( 2016, 8, 14 ), 20.00, 'Weekly' ) }.not_to raise_error
    end

    describe 'once created' do

      let( :date ) { Date.new( 2016, 8, 14 ) }
      let( :amount ) { 20.00 }
      let( :description ) { 'Weekly' }
      let( :expense ) { WeeklyExpense.new( date, amount, description ) }

      it 'knows its date' do
        expect( expense.date ).to eq( date )
      end

      it 'knows its amount' do
        expect( expense.amount ).to eq( amount )
      end

      it 'knows its description' do
        expect( expense.description ).to eq( description )
      end

      it 'handles equality' do
        expect( expense ).to eq( WeeklyExpense.new( date, amount, description ) )
      end

      describe 'when testing applicability' do

        it 'applies on the same day' do
          expect( expense.applies_on?( date ) ).to be true
        end

        it 'has value on its day' do
          expect( expense.amount_for( date ) ).to eq( amount )
        end

        it 'applies a week later' do
          expect( expense.applies_on?( date + 7 ) ).to be true
        end

        it 'has value a week later' do
          expect( expense.amount_for( date + 7 ) ).to eq( amount )
        end

        it 'applies a week prior' do
          expect( expense.applies_on?( date - 7 ) ).to be true
        end

        it 'has value a week prior' do
          expect( expense.amount_for( date - 7 ) ).to eq( amount )
        end

        it 'does not apply for the rest of the week' do
          1.upto( 6 ) do |i|
            expect( expense.applies_on?( date + i ) ).to be false
          end
        end

        it 'has no value for the rest of the week' do
          1.upto( 6 ) do |i|
            expect( expense.amount_for( date + i ) ).to eq( 0.00 )
          end
        end

      end

    end

  end

end
