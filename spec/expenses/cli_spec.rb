require 'spec_helper'

module Expenses

  describe CLI do

    it 'can be created' do
      expect { CLI.new }.not_to raise_error
    end

    describe 'project command' do

      it 'has a project command' do
        expect( subject ).to respond_to( :project )
      end

      describe 'when run' do

        let( :filename ) { 'filename' }
        let( :config ) { double( 'config' ) }
        let( :projection_command ) { double( 'projection command' ) }
        let( :options ) { double( 'options' ) }

        before( :each ) do
          allow( ConfigurationLoader ).to receive( :load ).and_return( config )
          allow( ProjectionCommand ).to receive( :new ).and_return( projection_command )
          allow( projection_command ).to receive( :run )
          allow( subject ).to receive( :options ).and_return( options )
        end

        after( :each ) do
          subject.project( filename )
        end

        it 'opens the input file' do
          expect( ConfigurationLoader ).to receive( :load ).with( filename )
        end

        it 'creates a projection command object' do
          expect( ProjectionCommand ).to receive( :new )
        end

        it 'defers to the projection command' do
          expect( projection_command ).to receive( :run ).with( options, config )
        end

      end

    end

  end

end
