require 'rails_helper'

RSpec.describe SeatsController, type: :controller do
	context 'Success' do
		
		context 'GET index' do
			it 'should show all seats successfully' do
				seat1 = FactoryGirl.create(:seat)
				seat2 = FactoryGirl.create(:seat)
	      get :index, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
	  context 'GET show' do
	    it 'should show seat with given id successfully' do
	      seat = FactoryGirl.create(:seat)
	      get :show, id: seat.id, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
		context 'POST create' do
			it 'should be a valid seat creation' do
				seat = FactoryGirl.create(:seat)
				post :create, seat: {type_of_seat:seat.type_of_seat, theatre_id:seat.theatre_id, auditorium_id:seat.auditorium_id, viewer_id:seat.viewer_id},format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'PUT update' do
			it 'should be a valid seat updation' do
				seat = FactoryGirl.create(:seat)
				put :update, id:seat.id, seat: {type_of_seat:"upper", theatre_id:seat.theatre_id, auditorium_id:seat.auditorium_id, viewer_id:seat.viewer_id}, format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'DELETE destroy' do
			it 'should be a valid seat deletion' do
				seat = FactoryGirl.create(:seat)
				delete :destroy, id:seat.id, format: 'json'
				response.should have_http_status(:ok)
			end
		end
	end

	context'Failure' do

		context 'GET show' do
			it 'should not show a valid seat' do
				seat = FactoryGirl.create(:seat)
				get :show, id:33, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
		context 'POST create' do
			it 'should not create a seat with nil entries' do
				seat = FactoryGirl.create(:seat)
				post :create, seat: {type_of_seat:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a seat with invalid theatre_id' do
				seat = FactoryGirl.create(:seat)
				post :create, seat: {theatre_id:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a seat with invalid auditorium_id' do
				seat = FactoryGirl.create(:seat)
				post :create, seat: {auditorium_id:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a seat with invalid viewer_id' do
				seat = FactoryGirl.create(:seat)
				post :create, seat: {viewer_id:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
		end
		context 'PUT update' do
			it 'should not be a valid seat updation with invalid id' do
				seat = FactoryGirl.create(:seat)
				put :update, id:111, seat: {type_of_seat:seat.type_of_seat}, format: 'json'
				response.should have_http_status(:not_found)
			end	
			it 'should not be a valid seat updation with invalid input' do
				seat = FactoryGirl.create(:seat)
				put :update, id:seat.id, seat: {type_of_seat:nil}, format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end	
			it 'should not be a valid seat updation with invalid theatre id' do
				seat = FactoryGirl.create(:seat)
				put :update, id:111, seat: {type_of_seat:seat.type_of_seat, theatre_id:7777}, format: 'json'
				response.should have_http_status(:not_found)
			end
			it 'should not be a valid seat updation with invalid auditorium id' do
				seat = FactoryGirl.create(:seat)
				put :update, id:111, seat: {type_of_seat:seat.type_of_seat, auditorium_id:778}, format: 'json'
				response.should have_http_status(:not_found)
			end
			it 'should not be a valid seat updation with invalid viewer id' do
				seat = FactoryGirl.create(:seat)
				put :update, id:111, seat: {type_of_seat:seat.type_of_seat, viewer_id:2222}, format: 'json'
				response.should have_http_status(:not_found)
			end
		end 
		context 'DELETE destroy' do
			it 'should not be a valid seat deletion with invalid id' do
				seat = FactoryGirl.create(:seat)
				delete :destroy, id:123, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
	end
end