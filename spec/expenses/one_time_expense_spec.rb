require 'spec_helper'

module Expenses

  describe OneTimeExpense do

    let( :date ) { Date.new( 2016, 8, 14 ) }

    it 'is creatable with a date, an amount, and a description' do
      expect{ OneTimeExpense.new( Date.new( 2016, 8, 14 ), 40.00, 'A one-time expense' ) }.not_to raise_error
    end

    describe 'once created' do

      let( :amount ) { 40.00 }
      let( :description ) { 'A one-time expense' }
      let( :expense ) { OneTimeExpense.new( date, amount, description ) }

      it 'knows its date' do
        expect( expense.date ).to eq( date )
      end

      it 'knows its amount' do
        expect( expense.amount ).to eq( amount )
      end

      it 'knows its description' do
        expect( expense.description ).to eq( description )
      end

      describe 'testing applicability' do

        it 'applies on its date' do
          expect( expense.applies_on?( date ) ).to be true
        end

        it 'has an amount on its date' do
          expect( expense.amount_for( date ) ).to eq( amount )
        end

        it 'does not apply before its date' do
          expect( expense.applies_on?( date.prev_day ) ).to be false
        end

        it 'has 0 value before its date' do
          expect( expense.amount_for( date.prev_day ) ).to eq( 0.00 )
        end

        it 'does not apply after its date' do
          expect( expense.applies_on?( date.next_day ) ).to be false
        end

        it 'has 0 value after its date' do
          expect( expense.amount_for( date.next_day ) ).to eq( 0.00 )
        end

      end

    end

    it 'handles equivalency' do
      expect( OneTimeExpense.new( date, 40.00, 'Something' ) ).to eq( OneTimeExpense.new( date, 40.00, 'Something' ) )
    end

  end

end
