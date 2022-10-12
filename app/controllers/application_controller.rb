class ApplicationController < ActionController::API
  include ActionController::Cookies

  # GET /spices
  def index
    spices = Spice.all
    render json: spices
  end

  # # GET /spices/:id
  # def show
  #   spice = find_spice
  #   render json: spice
  # rescue ActiveRecord::RecordNotFound
  #   render_not_found
  # end

  # POST /spices
  def create
    spice = Spice.create(spice_params)
    render json: spice, status: :created
  end

  def update
    spice = find_spice
    spice.update(spice_params)
    render json: spice
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def destroy
    spice = find_spice
    spice.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end


  private

  def spice_params
    params.permit(:title, :image, :description, :notes, :rating)
  end

  def find_spice
    Spice.find_by(id: params[:id])
  end

  def render_not_found
    render json: { error: "Spice not found."}, status: :render_not_found
  end

end
