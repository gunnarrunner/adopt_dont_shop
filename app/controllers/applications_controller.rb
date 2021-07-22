class ApplicationsController < ApplicationController
  
  def show
    @application = Application.find(params[:id])
    @applicant_pets = @application.pets
    @pet_count = @application.pet_count

    if params[:description]
      @application.status = 1
    elsif params[:search]
      @pets = Pet.search(params[:search])
    else
      @pets = []
    end

  end

  def new
  end

  def create
    application = Application.new(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  # def edit
    
  # end

  # def update
    
  # end

  # def destroy
    
  # end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end