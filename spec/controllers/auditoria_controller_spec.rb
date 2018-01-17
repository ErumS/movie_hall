require 'rails_helper'

RSpec.describe AuditoriaController, type: :controller do
	context 'Success' do
		
		context 'GET index' do
			it 'should show all auditoria successfully' do
				auditorium1 = FactoryGirl.create(:auditorium)
				auditorium2 = FactoryGirl.create(:auditorium)
	      get :index, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
	  context 'GET show' do
	    it 'should show auditorium with given id successfully' do
	      auditorium = FactoryGirl.create(:auditorium)
	      get :show, id: auditorium.id, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
		context 'POST create' do
			it 'should be a valid auditorium creation' do
				auditorium = FactoryGirl.create(:auditorium)
				post :create, auditorium: {screen_size:auditorium.screen_size, no_of_seats:auditorium.no_of_seats, theatre_id:auditorium.theatre_id, movie_id:auditorium.movie_id},format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'PUT update' do
			it 'should be a valid auditorium updation' do
				auditorium = FactoryGirl.create(:auditorium)
				put :update, id:auditorium.id, auditorium: {screen_size:"4x4", no_of_seats:60, theatre_id:auditorium.theatre_id}, format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'DELETE destroy' do
			it 'should be a valid auditorium deletion' do
				auditorium = FactoryGirl.create(:auditorium)
				delete :destroy, id:auditorium.id, format: 'json'
				response.should have_http_status(:ok)
			end
		end
	end

	context'Failure' do

		context 'GET show' do
			it 'should not show a valid auditorium' do
				auditorium = FactoryGirl.create(:auditorium)
				get :show, id:33, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
		context 'POST create' do
			it 'should not create an auditorium with invalid input' do
				auditorium = FactoryGirl.create(:auditorium)
				post :create, auditorium: {screen_size:auditorium.screen_size, no_of_seats:5000}, format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create an auditorium with nil entries' do
				auditorium = FactoryGirl.create(:auditorium)
				post :create, auditorium: {screen_size:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create an auditorium with invalid theatre id' do
				auditorium = FactoryGirl.create(:auditorium)
				post :create, auditorium: {theatre_id:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create an auditorium with invalid movie id' do
				auditorium = FactoryGirl.create(:auditorium)
				post :create, auditorium: {movie_id:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
		end
		context 'PUT update' do
			it 'should not be a valid auditorium updation with invalid id' do
				auditorium = FactoryGirl.create(:auditorium)
				put :update, id:111, auditorium: {screen_size:auditorium.screen_size, no_of_seats:auditorium.no_of_seats}, format: 'json'
				response.should have_http_status(:not_found)
			end	
			it 'should not be a valid auditorium updation with invalid input' do
				auditorium = FactoryGirl.create(:auditorium)
				put :update, id:auditorium.id, auditorium: {screen_size:auditorium.screen_size, no_of_seats:nil}, format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end	
			it 'should not be a valid auditorium updation with invalid theatre id' do
				auditorium = FactoryGirl.create(:auditorium)
				put :update, id:111, auditorium: {screen_size:auditorium.screen_size, no_of_seats:auditorium.no_of_seats, theatre_id:888}, format: 'json'
				response.should have_http_status(:not_found)
			end
			it 'should not be a valid auditorium updation with invalid movie id' do
				auditorium = FactoryGirl.create(:auditorium)
				put :update, id:111, auditorium: {screen_size:auditorium.screen_size, no_of_seats:auditorium.no_of_seats, movie_id:7777}, format: 'json'
				response.should have_http_status(:not_found)
			end
		end 
		context 'DELETE destroy' do
			it 'should not be a valid auditorium deletion with invalid id' do
				auditorium = FactoryGirl.create(:auditorium)
				delete :destroy, id:123, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
	end
end