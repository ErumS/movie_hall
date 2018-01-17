class AuditoriaController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
    @auditoria = Auditorium.all
    if @auditoria
      respond_to do |format|
        format.json {render json: {auditoria: @auditoria}, status: :ok }
      end
    else
      respond_to do |format| 
        format.json {render json: {error: @auditoria.errors}, status: :not_found}
      end
    end
  end 

  def show
    begin
      @auditorium = Auditorium.find(params[:id])
      respond_to do |format|
        format.json {render json: {auditorium: @auditorium}, status: :ok}
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found} 
      end
    end
  end

  def new
    @auditorium = Auditorium.new
  end 

  def edit
    @auditorium = Auditorium.find(params[:id])
  end

  def create
    begin
      @auditorium = Auditorium.new(auditorium_params)
      @theatre = Theatre.find_by_id(params[:theatre_id])
      @movie = Movie.find_by_id(params[:movie_id])
      if @auditorium.save
        respond_to do |format|
          format.json {render json: {auditorium: @auditorium}, status: :ok}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @auditorium.errors}, status: :unprocessable_entity}
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
      @auditorium = Auditorium.find(params[:id]) 
      if @auditorium.update(auditorium_params)  
        respond_to do |format|
          format.json {render json: {auditorium: @auditorium}, status: :ok}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @auditorium.errors}, status: :unprocessable_entity}
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
      @auditorium = Auditorium.find(params[:id])
      if @auditorium.destroy
        respond_to do |format|
          format.json {render json: {message: 'Successfully deleted'}, status: :ok}
        end  
      else
        respond_to do |format|
          format.json {render json: {error: @auditorium.errors}, status: :unprocessable_entity}
        end  
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
      end
    end
  end

  private
    def auditorium_params
      params.require(:auditorium).permit(:screen_size, :no_of_seats, :theatre_id, :movie_id)
    end
end