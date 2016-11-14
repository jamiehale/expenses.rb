require 'spec_helper'

module Expenses

  describe BiWeeklyExpense do

    it 'is creatable with a date, an amount, and a description' do
      expect{ BiWeeklyExpense.new( Date.new( 2016, 8, 14 ), 20.00, 'Weekly' ) }.not_to raise_error
    end

    describe 'once created' do

      let( :date ) { Date.new( 2016, 8, 14 ) }
      let( :amount ) { 20.00 }
      let( :description ) { 'Weekly' }
      let( :expense ) { BiWeeklyExpense.new( date, amount, description ) }

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
        expect( expense ).to eq( BiWeeklyExpense.new( date, amount, description ) )
      end

      describe 'when testing applicability' do

        it 'applies on the same day' do
          expect( expense.applies_on?( date ) ).to be true
        end

        it 'has value on the same day' do
          expect( expense.amount_for( date ) ).to eq( amount )
        end

        it 'applies 2 weeks later' do
          expect( expense.applies_on?( date + 14 ) ).to be true
        end

        it 'has value 2 weeks later' do
          expect( expense.amount_for( date + 14 ) ).to eq( amount )
        end

        it 'applies 2 weeks prior' do
          expect( expense.applies_on?( date - 14 ) ).to be true
        end

        it 'has value 2 weeks prior' do
          expect( expense.amount_for( date - 14 ) ).to eq( amount )
        end

        it 'does not apply for the rest of the 2 weeks' do
          1.upto( 13 ) do |i|
            expect( expense.applies_on?( date + i ) ).to be false
          end
        end

        it 'does not have value for the rest of the 2 weeks' do
          1.upto( 13 ) do |i|
            expect( expense.amount_for( date + i ) ).to eq( 0.00 )
          end
        end

      end

    end

  end

end
