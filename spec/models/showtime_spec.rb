require 'rails_helper'

RSpec.describe Showtime, type: :model do
	context 'Validations' do

    context 'Success' do
  		it 'should be a valid showtime' do
    		FactoryGirl.build(:showtime).should be_valid
    	end
    	it 'should be a valid showtime' do
    		FactoryGirl.build(:showtime, time_of_show:"4:55").should be_valid
    	end
    end

    context 'Failure' do
    	it 'should not be a valid showtime' do
    		FactoryGirl.build(:showtime, time_of_show:nil).should_not be_valid
    	end
    	it 'should not be a valid showtime' do
    		FactoryGirl.build(:showtime, time_of_show:"444").should_not be_valid
    	end
    end
	end

  context 'Associations' do

    context 'Success' do
      it 'should belongs to movie' do
        movie = FactoryGirl.create(:movie)
        showtime = FactoryGirl.create(:showtime, movie_id:movie.id)
        showtime.movie.id.should eq movie.id
      end
      it 'should have many bookings' do
        showtime = FactoryGirl.create(:showtime)
        booking1 = FactoryGirl.create(:booking, showtime_id:showtime.id)
        booking2 = FactoryGirl.create(:booking, showtime_id:showtime.id)
        showtime.bookings.should include booking1
        showtime.bookings.should include booking2    
      end
      it 'should have many tickets' do
        showtime = FactoryGirl.create(:showtime)
        ticket1 = FactoryGirl.create(:ticket, showtime_id:showtime.id)
        ticket2 = FactoryGirl.create(:ticket, showtime_id:showtime.id)
        showtime.tickets.should include ticket1
        showtime.tickets.should include ticket2
      end
    end

    context 'Failure' do
      it 'should not belongs to movie' do
        movie1 = FactoryGirl.create(:movie)
        movie2 = FactoryGirl.create(:movie)
        showtime1 = FactoryGirl.create(:showtime, movie_id:movie1.id)
        showtime2 = FactoryGirl.create(:showtime, movie_id:movie2.id)
        showtime1.movie.id.should eq movie1.id
        showtime1.movie.id.should_not eq movie2.id
        showtime2.movie.id.should eq movie2.id
        showtime2.movie.id.should_not eq movie1.id
      end
      it 'should not have many bookings' do
        showtime = FactoryGirl.create(:showtime)
        booking1 = FactoryGirl.create(:booking)
        booking2 = FactoryGirl.create(:booking)
        showtime.bookings.should_not include booking1
        showtime.bookings.should_not include booking2    
      end
      it 'should not have many tickets' do
        showtime = FactoryGirl.create(:showtime)
        ticket1 = FactoryGirl.create(:ticket)
        ticket2 = FactoryGirl.create(:ticket)
        showtime.tickets.should_not include ticket1
        showtime.tickets.should_not include ticket2
      end
    end
  end
end