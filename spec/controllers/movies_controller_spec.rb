require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
	context 'Success' do
		
		context 'GET index' do
			it 'should show all movies successfully' do
				movie1 = FactoryGirl.create(:movie)
				movie2 = FactoryGirl.create(:movie)
	      get :index, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
	  context 'GET show' do
	    it 'should show movie with given id successfully' do
	      movie = FactoryGirl.create(:movie)
	      get :show, id: movie.id, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
		context 'POST create' do
			it 'should be a valid movie creation' do
				movie = FactoryGirl.create(:movie)
				post :create, movie: {name: movie.name, rating:movie.rating, theatre_id:movie.theatre_id},format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'PUT update' do
			it 'should be a valid movie updation' do
				movie = FactoryGirl.create(:movie)
				put :update, id:movie.id, movie: {name: "abc", rating:movie.rating, theatre_id:movie.theatre_id}, format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'DELETE destroy' do
			it 'should be a valid movie deletion' do
				movie = FactoryGirl.create(:movie)
				delete :destroy, id:movie.id, format: 'json'
				response.should have_http_status(:ok)
			end
		end
	end

	context'Failure' do

		context 'GET show' do
			it 'should not show a valid movie' do
				movie = FactoryGirl.create(:movie)
				get :show, id:33, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
		context 'POST create' do
			it 'should not create a movie with invalid input' do
				movie = FactoryGirl.create(:movie)
				post :create, movie: {name: movie.name, rating:555},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a movie with nil entries' do
				movie = FactoryGirl.create(:movie)
				post :create, movie: {name: nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a movie with invalid theatre id' do
				movie = FactoryGirl.create(:movie)
				post :create, movie: {theatre_id:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
		end
		context 'PUT update' do
			it 'should not be a valid movie updation with invalid id' do
				movie = FactoryGirl.create(:movie)
				put :update, id:111, movie: {name: "abc", rating:3}, format: 'json'
				response.should have_http_status(:not_found)
			end	
			it 'should not be a valid movie updation with invalid input' do
				movie = FactoryGirl.create(:movie)
				put :update, id:movie.id, movie: {name: "abc", rating:nil}, format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end	
			it 'should not be a valid movie updation with invalid theatre id' do
				movie = FactoryGirl.create(:movie)
				put :update, id:movie.id, movie: {name: "abc", theatre_id:55555}, format: 'json'
				response.should have_http_status(:not_found)
			end	
		end 
		context 'DELETE destroy' do
			it 'should not be a valid movie deletion with invalid id' do
				movie = FactoryGirl.create(:movie)
				delete :destroy, id:123, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
	end
end