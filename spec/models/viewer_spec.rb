require 'rails_helper'

RSpec.describe Viewer, type: :model do
	context 'Validations' do

    context 'Success' do
  		it 'should be a valid viewer' do
    		FactoryGirl.build(:viewer).should be_valid
    	end
    	it 'should be a valid viewer' do
    		FactoryGirl.build(:viewer, name:"ddsds").should be_valid
    	end
    	it 'should be a valid viewer' do
    		FactoryGirl.build(:viewer, phone_no:"223344556677").should be_valid
    	end
    end

    context 'Failure' do
    	it 'should not be a valid viewer' do
    		FactoryGirl.build(:viewer, name:"fvsvs", phone_no:"333").should_not be_valid
    	end
    	it 'should not be a valid viewer' do
    		FactoryGirl.build(:viewer, name:"ddsds", phone_no:"4455727673478378374898923").should_not be_valid
    	end
    	it 'should not be a valid viewer' do
    		FactoryGirl.build(:viewer, name:nil).should_not be_valid
    	end
    	it 'should not be a valid viewer' do
    		FactoryGirl.build(:viewer, phone_no:nil).should_not be_valid
    	end
    	it 'should not be a valid viewer' do
    		FactoryGirl.build(:viewer, name:nil, phone_no:nil).should_not be_valid
    	end
    	it 'should not be a valid viewer' do
    		FactoryGirl.build(:viewer, name:"ddsds", phone_no:nil).should_not be_valid
    	end
    	it 'should not be a valid viewer' do
    		FactoryGirl.build(:viewer, name:nil, phone_no:"443344556").should_not be_valid
    	end
    end
	end	

  context 'Associations' do

    context 'Success' do
      it 'should belongs to theatre' do
        theatre = FactoryGirl.create(:theatre, phone_no:"3344556677")
        viewer = FactoryGirl.create(:viewer ,theatre_id:theatre.id)
        viewer.theatre.id.should eq theatre.id
      end
      it 'should belongs to movie' do
        movie = FactoryGirl.create(:movie)
        viewer = FactoryGirl.create(:viewer ,movie_id:movie.id)
        viewer.movie.id.should eq movie.id
      end
      it 'should belongs to auditorium' do
        auditorium = FactoryGirl.create(:auditorium)
        viewer = FactoryGirl.create(:viewer ,auditorium_id:auditorium.id)
        viewer.auditorium.id.should eq auditorium.id
      end
      it 'should have many bookings' do
        viewer = FactoryGirl.create(:viewer)
        booking1 = FactoryGirl.create(:booking, viewer_id:viewer.id)
        booking2 = FactoryGirl.create(:booking, viewer_id:viewer.id)
        viewer.bookings.should include booking1
        viewer.bookings.should include booking2    
      end
      it 'should have many tickets' do
        viewer = FactoryGirl.create(:viewer)
        ticket1 = FactoryGirl.create(:ticket, viewer_id:viewer.id)
        ticket2 = FactoryGirl.create(:ticket, viewer_id:viewer.id)
        viewer.tickets.should include ticket1
        viewer.tickets.should include ticket2
      end
      it 'should have many seats' do
        viewer = FactoryGirl.create(:viewer)
        seat1 = FactoryGirl.create(:seat, viewer_id:viewer.id)
        seat2 = FactoryGirl.create(:seat, viewer_id:viewer.id)
        seat3 = FactoryGirl.create(:seat, viewer_id:viewer.id)
        viewer.seats.should include seat1
        viewer.seats.should include seat2
        viewer.seats.should include seat3
      end
    end

    context 'Failure' do
      it 'should not belongs to movie' do
        movie1 = FactoryGirl.create(:movie)
        movie2 = FactoryGirl.create(:movie)
        viewer1 = FactoryGirl.create(:viewer, movie_id:movie1.id)
        viewer2 = FactoryGirl.create(:viewer, movie_id:movie2.id)
        viewer1.movie.id.should eq movie1.id
        viewer1.movie.id.should_not eq movie2.id
        viewer2.movie.id.should eq movie2.id
        viewer2.movie.id.should_not eq movie1.id
      end
      it 'should not belongs to auditorium' do
        auditorium1 = FactoryGirl.create(:auditorium)
        auditorium2 = FactoryGirl.create(:auditorium)
        viewer1 = FactoryGirl.create(:viewer, auditorium_id:auditorium1.id)
        viewer2 = FactoryGirl.create(:viewer, auditorium_id:auditorium2.id)
        viewer1.auditorium.id.should eq auditorium1.id
        viewer1.auditorium.id.should_not eq auditorium2.id
        viewer2.auditorium.id.should eq auditorium2.id
        viewer2.auditorium.id.should_not eq auditorium1.id
      end
      it 'should not belongs to theatre' do
        theatre1 = FactoryGirl.create(:theatre, phone_no:"3344556677")
        theatre2 = FactoryGirl.create(:theatre, phone_no:"3344556677")
        viewer1 = FactoryGirl.create(:viewer, theatre_id:theatre1.id)
        viewer2 = FactoryGirl.create(:viewer, theatre_id:theatre2.id)
        viewer1.theatre.id.should eq theatre1.id
        viewer1.theatre.id.should_not eq theatre2.id
        viewer2.theatre.id.should eq theatre2.id
        viewer2.theatre.id.should_not eq theatre1.id
      end
      it 'should not have many bookings' do
        viewer = FactoryGirl.create(:viewer)
        booking1 = FactoryGirl.create(:booking)
        booking2 = FactoryGirl.create(:booking)
        viewer.bookings.should_not include booking1
        viewer.bookings.should_not include booking2    
      end  
      it 'should not have many tickets' do
        viewer = FactoryGirl.create(:viewer)
        ticket1 = FactoryGirl.create(:ticket)
        ticket2 = FactoryGirl.create(:ticket)
        viewer.tickets.should_not include ticket1
        viewer.tickets.should_not include ticket2
      end
      it 'should not have many seats' do
        viewer = FactoryGirl.create(:viewer)
        seat1 = FactoryGirl.create(:seat)
        seat2 = FactoryGirl.create(:seat)
        seat3 = FactoryGirl.create(:seat)
        viewer.seats.should_not include seat1
        viewer.seats.should_not include seat2
        viewer.seats.should_not include seat3
      end
    end
  end
end