class ShowtimesController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
    @showtimes = Showtime.all
    if @showtimes
      respond_to do |format|
        format.json {render json: {showtimes: @showtimes}, status: :ok }
      end
    else
      respond_to do |format| 
        format.json {render json: {error: @showtimes.errors}, status: :not_found}
      end
    end
  end 

  def show
    begin
      @showtime = Showtime.find(params[:id])
      respond_to do |format|
        format.json {render json: {showtime: @showtime}, status: :ok}
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found} 
      end
    end
  end

  def new
    @showtime = Showtime.new
  end 

  def edit
    @showtime = Showtime.find(params[:id])
  end

  def create
    begin
      @showtime = Showtime.new(showtime_params)
      @movie = Movie.find_by_id(params[:movie_id])
      if @showtime.save
        respond_to do |format|
          format.json {render json: {showtime: @showtime}, status: :ok}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @showtime.errors}, status: :unprocessable_entity}
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
      @showtime = Showtime.find(params[:id]) 
      if @showtime.update(showtime_params)  
        respond_to do |format|
          format.json {render json: {showtime: @showtime}, status: :ok}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @showtime.errors}, status: :unprocessable_entity}
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
      @showtime = Showtime.find(params[:id])
      if @showtime.destroy
        respond_to do |format|
          format.json {render json: {message: 'Successfully deleted'}, status: :ok}
        end  
      else
        respond_to do |format|
          format.json {render json: {error: @showtime.errors}, status: :unprocessable_entity}
        end  
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
      end
    end
  end

  private
    def showtime_params
      params.require(:showtime).permit(:time_of_show, :movie_id)
    end
end