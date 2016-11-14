require 'spec_helper'

module Expenses

  describe ProjectionCommand do

    let( :projector ) { double( 'projector' ) }
    let( :accounts ) { double( 'accounts' ) }
    let( :expenses ) { double( 'expenses' ) }
    let( :configuration ) { double( 'configuration', accounts: accounts, expenses: expenses ) }
    let( :start ) { Date.new( 2016, 8, 14 ) }
    let( :count ) { 9 }
    let( :options ) do
      o = {}
      o[ 'start' ] = start.to_s
      o[ 'count' ] = 9.to_s
      o
    end
    let( :reporter ) { double( 'reporter' ) }
    let( :results ) { double( 'results' ) }

    before( :each ) do
      allow( projector ).to receive( :project ).and_return( results )
      allow( reporter ).to receive( :report )
    end

    it 'exists' do
      expect{ ProjectionCommand.new }.not_to raise_error
    end

    it 'takes an optional projector' do
      expect( ProjectionCommand ).to respond_to( :new ).with( 0..2 ).arguments
    end

    it 'defers to the projector' do
      expect( projector ).to receive( :project ).with( start, count, accounts, expenses )
      ProjectionCommand.new( projector, reporter ).run( options, configuration )
    end

    it 'passes the results to the reporter' do
      expect( reporter ).to receive( :report ).with( results )
      ProjectionCommand.new( projector, reporter ).run( options, configuration )
    end

  end

end
