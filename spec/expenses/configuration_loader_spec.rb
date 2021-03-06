require 'spec_helper'
require 'stringio'

module Expenses

  describe ConfigurationLoader do

    let( :filename ) { 'filename' }
    let( :stream ) { StringIO.new }
    let( :loader ) { ConfigurationLoader.new }

    before( :each ) do
      allow( File ).to receive( :open ).and_yield( stream )
    end

    it 'responds to load' do
      expect( subject ).to respond_to( :load ).with( 1 ).argument
    end

    it 'returns a configuration' do
      expect( loader.load( filename ) ).to be_an_instance_of( Configuration )
    end

    it 'reads the file' do
      expect( File ).to receive( :open ).with( filename )
      loader.load( filename )
    end

    describe 'when loading' do

      before( :each ) do
        @configuration = loader.load( filename )
      end

      describe 'with an empty stream' do

        let( :stream ) { StringIO.new }

        it 'returns a configuration with no accounts' do
          expect( @configuration.accounts ).to be_empty
        end

        it 'returns a configuration with no expenses' do
          expect( @configuration.expenses ).to be_empty
        end

      end

      describe 'with a stream with an empty line' do

        let( :stream ) { StringIO.new( "\n" ) }

        it 'returns a configuration with no accounts' do
          expect( @configuration.accounts ).to be_empty
        end

        it 'returns a configuration with no expenses' do
          expect( @configuration.expenses ).to be_empty
        end

      end

      describe 'with a stream with a commented line' do

        let( :stream ) { StringIO.new( '#' ) }

        it 'returns a configuration with no accounts' do
          expect( @configuration.accounts ).to be_empty
        end

        it 'returns a configuration with no expenses' do
          expect( @configuration.expenses ).to be_empty
        end

      end

      describe 'with a stream with one account' do

        let( :stream ) { StringIO.new( 'account "Main" 0.00' ) }

        it 'returns a configuration with one account' do
          expect( @configuration.accounts ).to contain_exactly( Account.new( 'Main', 0.00 ) )
        end

      end

      describe 'with a stream with a one-time expense' do

        let( :stream ) { StringIO.new( 'once 2016-08-14 40.00 "A one-time expense"' ) }

        it 'returns a configuration with a one-time expense' do
          expect( @configuration.expenses ).to contain_exactly( OneTimeExpense.new( Date.new( 2016, 8, 14 ), 40.00, 'A one-time expense' ) )
        end

      end

      describe 'with a stream with a daily expense' do

        let( :stream ) { StringIO.new( 'daily 5.00 "A daily expense"' ) }

        it 'returns a configuration with a daily expense' do
          expect( @configuration.expenses ).to contain_exactly( DailyExpense.new( 5.00, 'A daily expense' ) )
        end

      end

      describe 'with a stream with a monthly expense' do

        let( :stream ) { StringIO.new( 'monthly 1 5.00 "A monthly expense"' ) }

        it 'returns a configuration with a monthly expense' do
          expect( @configuration.expenses ).to contain_exactly( MonthlyExpense.new( 1, 5.00, 'A monthly expense' ) )
        end

      end

      describe 'with a stream with an annual expense' do

        let( :stream ) { StringIO.new( 'annual 11-25 5.00 "An annual expense"' ) }

        it 'returns a configuration with an annual expense' do
          expect( @configuration.expenses ).to contain_exactly( AnnualExpense.new( 11, 25, 5.00, 'An annual expense' ) )
        end

      end

      describe 'with a stream with a weekly expense' do

        let( :stream ) { StringIO.new( 'weekly 2016-08-14 5.00 "A weekly expense"' ) }

        it 'returns a configuration with a weekly expense' do
          expect( @configuration.expenses ).to contain_exactly( WeeklyExpense.new( Date.new( 2016, 8, 14 ), 5.00, 'A weekly expense' ) )
        end

      end

      describe 'with a stream with a bi-weekly expense' do

        let( :stream ) { StringIO.new( 'biweekly 2016-08-14 5.00 "A bi-weekly expense"' ) }

        it 'returns a configuration with a bi-weekly expense' do
          expect( @configuration.expenses ).to contain_exactly( BiWeeklyExpense.new( Date.new( 2016, 8, 14 ), 5.00, 'A bi-weekly expense' ) )
        end

      end

      describe 'with a stream with a monthly budget expense' do

        let( :stream ) { StringIO.new( 'budget monthly 5.00 "A monthly budget expense"' ) }

        it 'returns a configuration with a monthly budget expense' do
          expect( @configuration.expenses ).to contain_exactly( MonthlyBudgetExpense.new( 5.00, 'A monthly budget expense' ) )
        end

      end

      describe 'with a stream with an annual budget expense' do

        let( :stream ) { StringIO.new( 'budget annual 5.00 "An annual budget expense"' ) }

        it 'returns a configuration with an annual budget expense' do
          expect( @configuration.expenses ).to contain_exactly( AnnualBudgetExpense.new( 5.00, 'An annual budget expense' ) )
        end

      end

    end

  end

end
