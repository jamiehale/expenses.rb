require 'spec_helper'

module Expenses

  describe MonthlyBudgetExpense do

    it 'is creatable with an amount and a description' do
      expect{ MonthlyBudgetExpense.new( 100.00, 'Monthly budget' ) }.not_to raise_error
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

    end

  end

end
