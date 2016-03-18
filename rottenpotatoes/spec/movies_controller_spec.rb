require 'rails_helper'
require 'spec_helper'

describe MoviesController, :type => :controller do
    context ':same_director action - happy path - when director value is present' do
        before do
            @m= double(Movie, :title => "Star Wars", :director => "director", :id => "1")
            Movie.stub(:find).with("1").and_return @m 
            @similar_movies = ['ET', 'Jaws', 'Star Wars']
            Movie.stub(:same_director_method).and_return @similar_movies
        end
        it 'should return similar movies based on director - happy path' do
            get :same_director, :id => @m.id
            assigns(:movies).should == @similar_movies
        end
        it 'should render view upon completion' do
            get :same_director, :id => @m.id
            response.should render_template(:same_director)
        end
    end
    context ':same_director action - sad path - when director value is not present' do
        it 'should redirect if director is nil' do
            @m= double(Movie, :title => "Star Wars", :director => "", :id => "1")
            Movie.stub(:find).with("1").and_return @m
            Movie.stub(:same_director_method).and_return nil
            get :same_director, :id => @m.id
            response.should redirect_to(movies_path)
            flash[:warning].should == "'#{@m.title}' has no director info"
        end
    end
    context ':destroy action' do
            before do
                @m= double(Movie, :title => "Star Wars", :director => "", :id => "1")
                Movie.stub(:find).and_return @m
            end
            it 'should destroy!' do
                @m.should_receive(:destroy)
                delete :destroy, {:id => "1"}
            end
    end
end
            