class BookingsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
    @bookings = Booking.all
    if @bookings
      respond_to do |format|
        format.json {render json: {bookings: @bookings}, status: :ok }
      end
    else
      respond_to do |format| 
        format.json {render json: {error: @bookings.errors}, status: :not_found}
      end
    end
  end 

  def show
    begin
      @booking = Booking.find(params[:id])
      respond_to do |format|
        format.json {render json: {booking: @booking}, status: :ok}
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found} 
      end
    end
  end

  def new
    @booking = Booking.new
  end 

  def edit
    @booking = Booking.find(params[:id])
  end

  def create
    begin
      @booking = Booking.new(booking_params)
      @theatre = Theatre.find_by_id(params[:theatre_id])
      @movie = Movie.find_by_id(params[:movie_id])
      @auditorium = Auditorium.find_by_id(params[:auditorium_id])
      @showtime = Showtime.find_by_id(params[:showtime_id])
      @viewer = Viewer.find_by_id(params[:viewer_id])
      if @booking.save
        respond_to do |format|
          format.json {render json: {booking: @booking}, status: :ok}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @booking.errors}, status: :unprocessable_entity}
        end
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
      end
    end
  end 

  def update
    begin
      @booking = Booking.find(params[:id]) 
      if @booking.update(booking_params)  
        respond_to do |format|
          format.json {render json: {booking: @booking}, status: :ok}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @booking.errors}, status: :unprocessable_entity}
        end
      end   
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
      end
    end    
  end
  
  def destroy
    begin
      @booking = Booking.find(params[:id])
      if @booking.destroy
        respond_to do |format|
          format.json {render json: {message: 'Successfully deleted'}, status: :ok}
        end  
      else
        respond_to do |format|
          format.json {render json: {error: @booking.errors}, status: :unprocessable_entity}
        end  
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
      end
    end
  end

  private
    def booking_params
      params.require(:booking).permit(:booking_type, :no_of_bookings, :theatre_id, :movie_id, :auditorium_id, :viewer_id, :showtime_id)
    end
end