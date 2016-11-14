require 'spec_helper'

module Expenses

  describe Account do

    it 'exists' do
      expect { Account.new }.not_to raise_error
    end

    it 'can be created with an account name' do
      expect( Account ).to respond_to( :new ).with( 0..2 ).arguments
    end

    describe 'when initialized' do

      let( :account ) { Account.new }

      it 'has an empty name' do
        expect( account.name ).to be_nil
      end

      it 'has a 0 balance' do
        expect( account.balance ).to eq( 0.00 )
      end

      describe 'with a name' do

        let( :name ) { 'Main' }
        let( :account ) { Account.new( name ) }

        it 'knows its name' do
          expect( account.name ).to eq( name )
        end

        it 'still has a 0 balance' do
          expect( account.balance ).to eq( 0.00 )
        end

        describe 'and a balance' do

          let( :balance ) { 1.23 }
          let( :account ) { Account.new( name, balance ) }

          it 'knows its name' do
            expect( account.name ).to eq( name )
          end

          it 'knows its balance' do
            expect( account.balance ).to eq( balance )
          end

        end

      end

      describe 'setting name' do

        let( :name ) { 'Main' }
        before( :each ) { account.name = name }

        it 'has a new name' do
          expect( account.name ).to eq( name )
        end

      end

      describe 'setting balance' do

        let( :balance ) { 1.23 }
        before( :each ) { account.balance = balance }

        it 'has a new balance' do
          expect( account.balance ).to eq( balance )
        end

      end

    end

    describe 'when comparing' do

      it 'knows equivalent accounts' do
        expect( Account.new( 'Main', 1.23 ) ).to eq( Account.new( 'Main', 1.23 ) )
      end

      it 'knows unequivalent accounts based on name' do
        expect( Account.new( 'Main', 1.23 ) ).not_to eq( Account.new( 'Savings', 1.23 ) )
      end

      it 'knows unequivalent accounts based on balance' do
        expect( Account.new( 'Main', 1.23 ) ).not_to eq( Account.new( 'Main', 4.56 ) )
      end

    end

  end

end
