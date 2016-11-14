require 'spec_helper'

module Expenses

  describe Reporter do

    it 'exists' do
      expect { Reporter.new }.not_to raise_error
    end

    it 'takes an options output stream' do
      expect( Reporter ).to respond_to( :new ).with( 0..1 ).arguments
    end

    it 'knows how to report' do
      expect( subject ).to respond_to( :report ).with( 1 ).argument
    end

    describe 'with a mock stream' do

      let( :stream ) { StringIO.new }
      let( :reporter ) { Reporter.new( stream ) }

      describe 'with empty results' do

        let( :results ) { double( 'results' ) }

        before( :each ) do
          allow( results ).to receive( :empty? ).and_return( true )
        end

        it 'outputs nothing' do
          reporter.report( results )
          expect( stream.string ).to be_empty
        end

      end

      describe 'with a single result' do

        let( :result ) { double( 'result' ) }
        let( :results ) { double( 'results' ) }
        let( :account_names ) { [ 'Main' ] }
        let( :first_line ) { '2016-08-14,1.23' }

        before( :each ) do
          allow( results ).to receive( :empty? ).and_return( false )
          allow( results ).to receive( :account_names ).and_return( account_names )
          allow( results ).to receive( :each_day ).and_yield( result )
          allow( result ).to receive( :to_csv ).and_return( first_line )
        end

        it 'outputs a header' do
          reporter.report( results )
          expect( stream.string.lines[ 0 ] ).to eq( "Date,Main\n" )
        end

        it 'outputs line for result' do
          reporter.report( results )
          expect( stream.string.lines[ 1 ] ).to eq( first_line + "\n" )
        end

      end

      describe 'with multiple results' do

        let( :result1 ) { double( 'result 1' ) }
        let( :result2 ) { double( 'result 2' ) }
        let( :results ) { double( 'results' ) }
        let( :account_names ) { [ 'Main' ] }
        let( :first_line ) { '2016-08-14,1.23' }
        let( :second_line ) { '2016-08-15,4.56' }

        before( :each ) do
          allow( results ).to receive( :empty? ).and_return( false )
          allow( results ).to receive( :account_names ).and_return( account_names )
          allow( results ).to receive( :each_day ).and_yield( result1 ).and_yield( result2 )
          allow( result1 ).to receive( :to_csv ).and_return( first_line )
          allow( result2 ).to receive( :to_csv ).and_return( second_line )
        end

        it 'outputs a header' do
          reporter.report( results )
          expect( stream.string.lines[ 0 ] ).to eq( "Date,Main\n" )
        end

        it 'outputs line for first result' do
          reporter.report( results )
          expect( stream.string.lines[ 1 ] ).to eq( first_line + "\n" )
        end

        it 'outputs line for second result' do
          reporter.report( results )
          expect( stream.string.lines[ 2 ] ).to eq( second_line + "\n" )
        end

      end

    end

  end

end
