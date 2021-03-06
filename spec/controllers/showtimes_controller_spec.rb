require 'rails_helper'

RSpec.describe ShowtimesController, type: :controller do
	context 'Success' do
		
		context 'GET index' do
			it 'should show all showtimes successfully' do
				showtime1 = FactoryGirl.create(:showtime)
				showtime2 = FactoryGirl.create(:showtime)
	      get :index, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
	  context 'GET show' do
	    it 'should show showtime with given id successfully' do
	      showtime = FactoryGirl.create(:showtime)
	      get :show, id: showtime.id, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
		context 'POST create' do
			it 'should be a valid showtime creation' do
				showtime = FactoryGirl.create(:showtime)
				post :create, showtime: {time_of_show:showtime.time_of_show, movie_id:showtime.movie_id},format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'PUT update' do
			it 'should be a valid showtime updation' do
				showtime = FactoryGirl.create(:showtime)
				put :update, id:showtime.id, showtime: {time_of_show:"4:55", movie_id:showtime.movie_id}, format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'DELETE destroy' do
			it 'should be a valid showtime deletion' do
				showtime = FactoryGirl.create(:showtime)
				delete :destroy, id:showtime.id, format: 'json'
				response.should have_http_status(:ok)
			end
		end
	end

	context'Failure' do

		context 'GET show' do
			it 'should not show a valid showtime' do
				showtime = FactoryGirl.create(:showtime)
				get :show, id:33, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
		context 'POST create' do
			it 'should not create a showtime with invalid input' do
				showtime = FactoryGirl.create(:showtime)
				post :create, showtime: {time_of_show: "45645", movie_id:showtime.movie_id},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a showtime with nil entries' do
				showtime = FactoryGirl.create(:showtime)
				post :create, showtime: {time_of_show:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a showtime with invalid movie id' do
				showtime = FactoryGirl.create(:showtime)
				post :create, showtime: {time_of_show: "45645", movie_id:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
		end
		context 'PUT update' do
			it 'should not be a valid showtime updation with invalid id' do
				showtime = FactoryGirl.create(:showtime)
				put :update, id:111, showtime: {time_of_show:showtime.time_of_show}, format: 'json'
				response.should have_http_status(:not_found)
			end	
			it 'should not be a valid showtime updation with invalid input' do
				showtime = FactoryGirl.create(:showtime)
				put :update, id:showtime.id, showtime: {time_of_show:nil}, format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end	
			it 'should not be a valid showtime updation with invalid movie id' do
				showtime = FactoryGirl.create(:showtime)
				put :update, id:111, showtime: {movie_id:nil}, format: 'json'
				response.should have_http_status(:not_found)
			end
		end 
		context 'DELETE destroy' do
			it 'should not be a valid showtime deletion with invalid id' do
				showtime = FactoryGirl.create(:showtime)
				delete :destroy, id:123, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
	end
end