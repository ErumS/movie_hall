require 'rails_helper'

RSpec.describe Theatre, type: :model do
  context 'Validations' do

    context 'Success' do
    	it 'should be a valid theatre' do
    		FactoryGirl.build(:theatre, name:"Inox", address:"University", phone_no:"444444443").should be_valid
    	end
      it 'should be a valid theatre' do
        FactoryGirl.build(:theatre, phone_no:"5588745437895").should be_valid
      end
    end

    context 'Failure' do
    	it 'should not be a valid theatre' do
    		FactoryGirl.build(:theatre, name:"Inox", address:"University", phone_no: "44434").should_not be_valid
    	end
    	it 'should not be a valid theatre' do
    		FactoryGirl.build(:theatre, phone_no: "44434678783487387874755").should_not be_valid
    	end
    	it 'should not be a valid theatre' do
    		FactoryGirl.build(:theatre, address: nil).should_not be_valid
    	end  
      it 'should not be a valid theatre' do
        FactoryGirl.build(:theatre, name:nil).should_not be_valid
      end 
      it 'should not be a valid theatre' do
        FactoryGirl.build(:theatre, phone_no: nil).should_not be_valid
      end 
      it 'should not be a valid theatre' do
        FactoryGirl.build(:theatre, address:nil, phone_no:nil).should_not be_valid
      end
      it 'should not be a valid theatre' do
        FactoryGirl.build(:theatre, name:nil, address:nil).should_not be_valid
      end
      it 'should not be a valid theatre' do
        FactoryGirl.build(:theatre, name:nil, phone_no:nil).should_not be_valid
      end 
      it 'should not be a valid theatre' do
        FactoryGirl.build(:theatre, name:nil, address:nil, phone_no:nil).should_not be_valid
      end
      it 'should not be a valid theatre' do
        FactoryGirl.build(:theatre, phone_no:454545).should_not be_valid
      end
    end
  end

  context 'Associations' do

    context 'Success' do
      it 'should have many movies' do
        theatre = FactoryGirl.create(:theatre, phone_no:"467574378")
        movie1 = FactoryGirl.create(:movie, theatre_id:theatre.id)
        movie2 = FactoryGirl.create(:movie, theatre_id:theatre.id)
        theatre.movies.should include movie1
        theatre.movies.should include movie2 
      end
      it 'should have many auditoria' do
        theatre = FactoryGirl.create(:theatre, phone_no:"467574378")
        audi1 = FactoryGirl.create(:auditorium, theatre_id:theatre.id)
        audi2 = FactoryGirl.create(:auditorium, theatre_id:theatre.id)
        theatre.auditoria.should include audi1
        theatre.auditoria.should include audi2
      end
      it 'should have many viewers' do
        theatre = FactoryGirl.create(:theatre, phone_no:"467574378")
        viewer1 = FactoryGirl.create(:viewer, theatre_id:theatre.id)
        viewer2 = FactoryGirl.create(:viewer, theatre_id:theatre.id)
        theatre.viewers.should include viewer1
        theatre.viewers.should include viewer2    
      end
      it 'should have many bookings' do
        theatre = FactoryGirl.create(:theatre, phone_no:"467574378")
        booking1 = FactoryGirl.create(:booking, theatre_id:theatre.id)
        booking2 = FactoryGirl.create(:booking, theatre_id:theatre.id)
        theatre.bookings.should include booking1
        theatre.bookings.should include booking2    
      end
      it 'should have many seats' do
        theatre = FactoryGirl.create(:theatre, phone_no:"467574378")
        seat1 = FactoryGirl.create(:seat, theatre_id:theatre.id)
        seat2 = FactoryGirl.create(:seat, theatre_id:theatre.id)
        seat3 = FactoryGirl.create(:seat, theatre_id:theatre.id)
        theatre.seats.should include seat1
        theatre.seats.should include seat2
        theatre.seats.should include seat3
      end
    end

    context 'Failure' do
      it 'should not have many movies' do
        theatre = FactoryGirl.create(:theatre, phone_no:"467574378")
        movie1 = FactoryGirl.create(:movie)
        movie2 = FactoryGirl.create(:movie)
        theatre.movies.should_not include movie1
        theatre.movies.should_not include movie2 
      end
      it 'should not have many auditoria' do
        theatre = FactoryGirl.create(:theatre, phone_no:"467574378")
        auditorium1 = FactoryGirl.create(:auditorium)
        auditorium2 = FactoryGirl.create(:auditorium)
        theatre.auditoria.should_not include auditorium1
        theatre.auditoria.should_not include auditorium2 
      end
      it 'should not have many viewers' do
        theatre = FactoryGirl.create(:theatre, phone_no:"467574378")
        viewer1 = FactoryGirl.create(:viewer)
        viewer2 = FactoryGirl.create(:viewer)
        theatre.viewers.should_not include viewer1
        theatre.viewers.should_not include viewer2 
      end
      it 'should not have many bookings' do
        theatre = FactoryGirl.create(:theatre, phone_no:"467574378")
        booking1 = FactoryGirl.create(:booking)
        booking2 = FactoryGirl.create(:booking)
        theatre.bookings.should_not include booking1
        theatre.bookings.should_not include booking2    
      end
      it 'should not have many seats' do
        theatre = FactoryGirl.create(:theatre, phone_no:"467574378")
        seat1 = FactoryGirl.create(:seat)
        seat2 = FactoryGirl.create(:seat)
        theatre.seats.should_not include seat1
        theatre.seats.should_not include seat2 
      end
    end
  end
end