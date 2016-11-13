require 'spec_helper'

module Expenses

  describe Configuration do

    it 'exists' do
      expect{ Configuration.new }.not_to raise_error
    end

    describe 'when initialized' do

      let( :configuration ) { Configuration.new }

      it 'has no accounts' do
        expect( configuration.accounts ).to be_empty
      end

      it 'has no expenses' do
        expect( configuration.expenses ).to be_empty
      end

      describe 'when an account is added' do

        let( :account ) { double( 'account' ) }
        before( :each ) { configuration.add_account( account ) }

        it 'has an account' do
          expect( configuration.accounts.length ).to eq( 1 )
        end

        it 'has the account' do
          expect( configuration.accounts[ 0 ] ).to eq( account )
        end

      end

      describe 'when an expenses is added' do

        let( :expense ) { double( 'expense' ) }
        before( :each ) { configuration.add_expense( expense ) }

        it 'has an expense' do
          expect( configuration.expenses.length ).to eq( 1 )
        end

        it 'has the expense' do
          expect( configuration.expenses[ 0 ] ).to eq( expense )
        end

      end

    end

  end

end
