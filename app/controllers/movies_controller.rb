class MoviesController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
    @movies = Movie.all
    if @movies
      respond_to do |format|
        format.json {render json: {movies: @movies}, status: :ok }
      end
    else
      respond_to do |format| 
        format.json {render json: {error: @movies.errors}, status: :not_found}
      end
    end
  end 

  def show
    begin
      @movie = Movie.find(params[:id])
      respond_to do |format|
        format.json {render json: {movie: @movie}, status: :ok}
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found} 
      end
    end
  end

  def new
    @movie = Movie.new
  end 

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    begin
      @movie = Movie.new(movie_params)
      @theatre = Theatre.find_by_id(params[:theatre_id])
      if @movie.save
        respond_to do |format|
          format.json {render json: {movie: @movie}, status: :ok}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @movie.errors}, status: :unprocessable_entity}
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
      @movie = Movie.find(params[:id]) 
      if @movie.update(movie_params)  
        respond_to do |format|
          format.json {render json: {movie: @movie}, status: :ok}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @movie.errors}, status: :unprocessable_entity}
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
      @movie = Movie.find(params[:id])
      if @movie.destroy
        respond_to do |format|
          format.json {render json: {message: 'Successfully deleted'}, status: :ok}
        end  
      else
        respond_to do |format|
          format.json {render json: {error: @movie.errors}, status: :unprocessable_entity}
        end  
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
      end
    end
  end

  private
    def movie_params
      params.require(:movie).permit(:name, :rating, :cast, :duration, :theatre_id)
    end
end