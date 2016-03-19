require 'rails_helper'
require 'spec_helper'

describe Movie do
    it '@all_ratings should match this' do
      Movie.all_ratings.should == ['G', 'PG', 'PG-13', 'NC-17', 'R']
    end
      
end

describe "retrieving a list of all movies by the same director" do
    context "when a director value is set" do
      it "should retrieve the list of the director's movies" do
        @movies = ["Movie 1", "Movie 2", "Movie 3"]
        Movie.stub(:where).with(:director => "Director").and_return @movies
        Movie.same_director_method("Director").should == @movies
      end
    end
    context "when a director value is not set" do
      @movies = ["Movie 1", "Movie 2", "Movie 3"]
      Movie.stub(:where).with(:director => "").and_return @movies
      it "should return nil" do
        @movies = Movie.where(:director => nil)
        @movies.should be_empty
      end
    end
end