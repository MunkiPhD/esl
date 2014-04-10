class LogFoodsController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end
end
