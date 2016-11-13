require 'spec_helper'

module Expenses

  describe AccountBalance do

    describe 'created with just a name' do

      let( :balance ) { AccountBalance.new( 'something' ) }

      it 'is creatable with a name' do
        expect{ balance }.not_to raise_error
      end

      it 'knows its name and default balance' do
        expect( balance ).to have_attributes( name: 'something', balance: 0.00 )
      end

    end

    it 'is also creatable with a value' do
      expect{ AccountBalance.new( 'something', 1.23 ) }.not_to raise_error
    end

  end

end
