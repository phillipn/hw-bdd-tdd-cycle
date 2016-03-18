require 'rails_helper'
require 'spec_helper'

describe Movie do
    it 'should receive proper vales upon being called' do
        Movie.should_receive(:same_director_method).with('director')
        Movie.same_director_method('director')
    end
end