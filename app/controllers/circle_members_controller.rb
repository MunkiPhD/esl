class CircleMembersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_circle, only: [:index, :pending, :join, :leave, :approve]
  before_action :set_user, only: [:approve]
  before_filter :authorize, only: [:approve, :pending]
  respond_to :html, :json, only: [:index, :pending]

  def index
    # this needs to be performed better, possibly a concern where it checks to see if the request is empty using 'base info' or something similar
    unless @circle.members.empty?
      @members = @circle.members.select(:id, :username)
    else
      @members = @circle.members
    end
  end


  def join
    @circle.request_membership(current_user)

    msg = ""
    if @circle.is_member? current_user
      msg = "You are now a member of #{@circle.name}!"
    elsif @circle.is_pending? current_user
      msg = "Your membership is awaiting approval."
    end

    respond_to do |format|
      format.html { redirect_to @circle, notice: msg }
      format.json { render action: 'circles/show', status: :created, location: @circle }
    end
  end


  def leave
    msg = ""
    if @circle.is_member? current_user 
      @circle.remove_member current_user
      msg = "You are no longer a member of #{@circle.name}"
    elsif @circle.is_pending? current_user
      @circle.remove_member current_user
      msg = "Your membership request has been cancelled."
    else
      msg = "You can't leave a circle you are not a member of!"
    end

    respond_to do |format|
      format.html { redirect_to @circle, notice: msg }
      format.json { render action: 'circles/show', status: :created, location: @circle }
    end
  end


  def pending
    @pending_members = @circle.pending_members
  end


  def approve
    @circle.approve_membership(@user, current_user)

    if @circle.is_member? @user
      msg = "#{@user.username} was approved."
    else
      msg = "#{@user.username} was NOT approved."
    end

    respond_to do |format|
      format.html { redirect_to pending_circle_members_path(@circle), notice: msg }
      format.json { render action: 'circles/show', status: :created, location: @circle }
    end
  end

  private

    def set_circle
      @circle = Circle.find(params[:circle_id])
    end

    def set_user
      @user = User.find(params[:id])
    end

    # custom authorize to throw an access denied if attempting to get into the authorize and pending actions
    def authorize
      raise CanCan::AccessDenied unless @circle.is_admin? current_user
    end
end
