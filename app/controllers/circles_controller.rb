class CirclesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  #before_action :set_circle, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource except: [:index, :new, :create] #only: [:show, :edit, :update, :destroy]

  # GET /circles
  # GET /circles.json
  def index
    @circles = Circle.all
  end

  # GET /circles/1
  # GET /circles/1.json
  def show
  end

  # GET /circles/new
  def new
    @circle = Circle.new
  end

  # GET /circles/1/edit
  def edit
  end

  # POST /circles
  # POST /circles.json
  def create
    @circle = current_user.circles.build(circle_params)

    respond_to do |format|
      if @circle.save
        format.html { redirect_to @circle, notice: 'Circle was successfully created.' }
        format.json { render action: 'show', status: :created, location: @circle }
      else
        format.html { render action: 'new' }
        format.json { render json: @circle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /circles/1
  # PATCH/PUT /circles/1.json
  def update
    respond_to do |format|
      if @circle.update(circle_params)
        format.html { redirect_to @circle, notice: 'Circle was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @circle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /circles/1
  # DELETE /circles/1.json
  def destroy
    @circle.destroy
    respond_to do |format|
      format.html { redirect_to circles_url }
      format.json { head :no_content }
    end
  end


  def join
    current_user.grant :circle_member, @circle
    respond_to do |format|
      format.html { redirect_to @circle, notice: "You are now a member of #{@circle.name}!" }
      format.json { render action: 'show', status: :created, location: @circle }
    end
  end


  def leave
    msg = ""
    if current_user.has_role? :circle_member, @circle
      current_user.revoke :circle_member, @circle
      msg = "You are no longer a member of #{@circle.name}"
    else
      msg = "You can't leave a circle you are not a member of!"
    end
    respond_to do |format|
      format.html { redirect_to circles_url, notice: msg }
      format.json { render action: 'show', status: :created, location: @circle }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_circle
      @circle = Circle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def circle_params
      params.require(:circle).permit(:name, :motto, :description, :is_public)
    end
end
