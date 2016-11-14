require 'spec_helper'

module Expenses

  describe Projector do

    it 'can be created' do
      expect{ Projector.new }.not_to raise_error
    end

    it 'responds to project' do
      expect( subject ).to respond_to( :project ).with( 4 ).argument
    end

    describe 'projecting' do

      let( :start ) { Date.new( 2016, 8, 14 ) }
      let( :starting_balance ) { 1.23 }
      let( :account ) { double( 'account', name: 'Main', balance: starting_balance ) }
      let( :accounts ) { [ account ] }
      let( :expenses ) { [] }
      let( :projector ) { Projector.new }
      
      before( :each ) do
        @results = projector.project( start, 1, accounts, expenses )
      end

      it 'returns projection results' do
        expect( @results ).to be_an_instance_of( ProjectionResults )
      end

      it 'sets the resulting account names' do
        expect( @results.account_names ).to contain_exactly( 'Main' )
      end

      it 'returns a single result' do
        expect( @results.days.length ).to eq( 1 )
      end

      it 'sets the first balance to the starting balance from the account' do
        expect( @results.days[ 0 ].balances[ 0 ] ).to eq( starting_balance )
      end

      it 'returns an array of increasing dates from today' do
        date = start
        @results.each_day do |result|
          expect( result.date ).to eq( date )
          date = date.next_day
        end
      end

      describe 'with an expense' do

        let( :expense_amount ) { 1.00 }
        let( :expense ) { OneTimeExpense.new( start, expense_amount, 'An expense' ) }
        let( :expenses ) { [ expense ] }

        it 'returns a single result' do
          expect( @results.days.length ).to eq( 1 )
        end

        it 'subtracts the expense from the balance' do
          expect( @results.days[ 0 ].balances[ 0 ] ).to eq( starting_balance - expense_amount )
        end

      end

    end

  end

end
