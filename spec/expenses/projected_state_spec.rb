require 'spec_helper'

module Expenses

  describe ProjectedState do

    it 'exists' do
      expect{ ProjectedState.new }.not_to raise_error
    end

    it 'takes an optional date' do
      expect( ProjectedState ).to respond_to( :new ).with( 0..1 ).arguments
    end

    describe 'once created' do

      let( :state ) { ProjectedState.new }

      it 'has a default date of today' do
        expect( state.date ).to eq( Date.today )
      end

      it 'starts with no balances' do
        expect( state.balances ).to be_empty
      end

      describe 'with a date' do

        let( :date ) { Date.new( 2016, 12, 2 ) }
        let( :state ) { ProjectedState.new( date ) }

        it 'has the passed date' do
          expect( state.date ).to eq( date )
        end

        it 'still has no balances' do
          expect( state.balances ).to be_empty
        end

        describe 'with a balance' do

          let( :balance ) { 1.23 }

          before( :each ) do
            state.add_balance( balance )
          end

          it 'has 1 balance' do
            expect( state.balances ).to contain_exactly( balance )
          end

          it 'converts to csv' do
            expect( state.to_csv ).to eq( date.to_s + ',' + balance.to_s )
          end

        end

      end

    end

  end

end
