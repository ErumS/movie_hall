require 'rails_helper'

RSpec.describe ViewersController, type: :controller do
	context 'Success' do
		
		context 'GET index' do
			it 'should show all viewers successfully' do
				viewer1 = FactoryGirl.create(:viewer, phone_no:"546382900")
				viewer2 = FactoryGirl.create(:viewer, phone_no:"546382900")
	      get :index, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
	  context 'GET show' do
	    it 'should show viewer with given id successfully' do
	      viewer = FactoryGirl.create(:viewer, phone_no:"546382900")
	      get :show, id: viewer.id, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
		context 'POST create' do
			it 'should be a valid viewer creation' do
				viewer = FactoryGirl.create(:viewer, phone_no:"546382900")
				post :create, viewer: {name: viewer.name, phone_no:viewer.phone_no, theatre_id:viewer.theatre_id, auditorium_id:viewer.auditorium_id, movie_id:viewer.movie_id},format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'PUT update' do
			it 'should be a valid viewer updation' do
				viewer = FactoryGirl.create(:viewer, phone_no:"546382900")
				put :update, id:viewer.id, viewer: {name: "abc", phone_no:viewer.phone_no, theatre_id:viewer.theatre_id, auditorium_id:viewer.auditorium_id, movie_id:viewer.movie_id}, format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'DELETE destroy' do
			it 'should be a valid viewer deletion' do
				viewer = FactoryGirl.create(:viewer, phone_no:"546382900")
				delete :destroy, id:viewer.id, format: 'json'
				response.should have_http_status(:ok)
			end
		end
	end

	context'Failure' do

		context 'GET show' do
			it 'should not show a valid viewer' do
				viewer = FactoryGirl.create(:viewer, phone_no:"546382900")
				get :show, id:33, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
		context 'POST create' do
			it 'should not create a viewer with invalid input' do
				viewer = FactoryGirl.create(:viewer, phone_no:"546382900")
				post :create, viewer: {name: viewer.name, phone_no:"1234", theatre_id:viewer.theatre_id, auditorium_id:viewer.auditorium_id, movie_id:viewer.movie_id},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a viewer with nil entries' do
				viewer = FactoryGirl.create(:viewer, phone_no:"546382900")
				post :create, viewer: {name: nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a viewer with invalid theatre_id' do
				viewer = FactoryGirl.create(:viewer, phone_no:"546382900")
				post :create, viewer: {theatre_id: nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a viewer with invalid movie_id' do
				viewer = FactoryGirl.create(:viewer, phone_no:"546382900")
				post :create, viewer: {movie_id: nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a viewer with invalid auditorium_id' do
				viewer = FactoryGirl.create(:viewer, phone_no:"546382900")
				post :create, viewer: {auditorium_id: nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
		end
		context 'PUT update' do
			it 'should not be a valid viewer updation with invalid id' do
				viewer = FactoryGirl.create(:viewer, phone_no:"546382900")
				put :update, id:111, viewer: {name: "abc", phone_no:viewer.phone_no}, format: 'json'
				response.should have_http_status(:not_found)
			end	
			it 'should not be a valid viewer updation with invalid input' do
				viewer = FactoryGirl.create(:viewer, phone_no:"546382900")
				put :update, id:viewer.id, viewer: {name: "abc", phone_no:nil}, format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end	
			it 'should not be a valid viewer updation with invalid theatre id' do
				viewer = FactoryGirl.create(:viewer, phone_no:"546382900")
				put :update, id:111, viewer: {name: "abc", phone_no:viewer.phone_no, theatre_id:888}, format: 'json'
				response.should have_http_status(:not_found)
			end	
			it 'should not be a valid viewer updation with invalid movie id' do
				viewer = FactoryGirl.create(:viewer, phone_no:"546382900")
				put :update, id:111, viewer: {name: "abc", phone_no:viewer.phone_no, movie_id:888}, format: 'json'
				response.should have_http_status(:not_found)
			end	
			it 'should not be a valid viewer updation with invalid auditorium id' do
				viewer = FactoryGirl.create(:viewer, phone_no:"546382900")
				put :update, id:111, viewer: {name: "abc", phone_no:viewer.phone_no, auditorium_id:3456}, format: 'json'
				response.should have_http_status(:not_found)
			end	
		end 
		context 'DELETE destroy' do
			it 'should not be a valid viewer deletion with invalid id' do
				viewer = FactoryGirl.create(:viewer, phone_no:"546382900")
				delete :destroy, id:123, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
	end
end