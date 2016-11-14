require 'spec_helper'

module Expenses

  describe ProjectionResults do

    it 'exists' do
      expect { ProjectionResults.new }.not_to raise_error
    end

    it 'starts empty' do
      expect( ProjectionResults.new ).to be_empty
    end

    it 'has no account names' do
      expect( ProjectionResults.new.account_names ).to be_empty
    end

    it 'can be created with names' do
      expect( ProjectionResults.new( %w( First Second ) ).account_names ).to contain_exactly( 'First', 'Second' )
    end

  end

end
