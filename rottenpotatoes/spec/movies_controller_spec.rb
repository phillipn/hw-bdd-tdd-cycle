require 'rails_helper'
require 'spec_helper'

describe MoviesController, :type => :controller do
     describe 'same_director action' do 
        it 'same_director action should render view if director is not nil' do
            @m = double('Movie', :id => "123", :director => "Steve", :title => "Gladiator")
            allow(Movie).to receive(:find).with("123").and_return(@m)
            get :same_director, :id => @m.id
            response.should render_template(:same_director)
        end
        it 'same_director action should redirect if director is nil' do
            @m = double('Movie', :id => "123", :director => "", :title => "Gladiator")
            allow(Movie).to receive(:find).with("123").and_return(@m)
            get :same_director, :id => @m.id
            response.should redirect_to movies_path
        end
    end
    
    describe "index action" do
        it 'should display title sort properly' do
           Movie.order(:title => :asc).to_sql.should =~ /ORDER BY "movies"."title" ASC/
           get :index, :sort => 'title'
        end
        it 'should display release_date sort properly' do
           Movie.order(:release_date => :asc).to_sql.should =~ /ORDER BY "movies"."release_date" ASC/
           get :index, :sort => 'release_date'
        end
    end

    describe "edit action" do
        before :each do
            @m = double('Movie', :id => "123", :title => "Gladiator")
            allow(Movie).to receive(:find).with("123").and_return(@m)
        end
        it "should allow movie date to be changed" do
            get :edit, :id => "123"
            response.should render_template("edit")
        end
    end
    
    describe "show action" do
        it "should show form for new movie" do
            @m = double('Movie', :id => "123", :title => "Gladiator")
            Movie.stub(:find).with("123").and_return(@m)
            get :show, :id => "123" 
            response.should render_template("show")
        end
    end
    
    describe 'update action' do
        before :each do
            @m = double('Movie', :title => "Gladiator", :id => "123")
            Movie.stub(:find).and_return(@m)
        end
    
        it 'should update and show movie' do
            @m.should receive(:update_attributes!)
            put :update,  :movie => { :title => "Whatever"},  :id => "123" 
            response.should redirect_to(movie_path(@m))
        end
    end
    
    describe 'destroy action' do
        it 'should destroy a movie' do
            @m = double('Movie', :id => "123", :title => "Gladiator")
            Movie.stub(:find).and_return(@m)
            @m.should receive(:destroy)
            delete :destroy, :id => "123"
            response.should redirect_to(movies_path)
        end
    end
  
    describe 'create action' do
        it 'should redirect to movies_path once completed' do
            @m = double(:title => "Gladiator", :director => "Me", :id => "123")
            post :create,  :movie => {:id => "123"} 
            response.should redirect_to(movies_path)
        end
    end
end
