class UsersController < ApplicationController
  before_action :set_user, only: %i[ show liked feed followers following discover ]
  before_action :authorize_user, only: [:show, :edit, :update, :destroy, :feed, :liked, :discover]

  def index
    @users = policy_scope(User)
  end

  def show
    @follow_requests = policy_scope(FollowRequest).where({ :recipient_id => @user.id, :status => 'accepted' })
    authorize @user
  end

  def liked
    if policy(@user).liked?
      @liked_photos = @user.liked_photos
    else
      @liked_photos = []
      @liked_photos_private = true
    end
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
    authorize @user
    if @user.save
      redirect_to @user, notice: "User was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  def feed
    @photos = policy_scope(current_user.feed)
    authorize current_user, :feed?
  end

  def discover
    @users = User.where(private: false)
    authorize :user, :discover?
  end

  private

  def set_user
    if params[:username]
      @user = User.find_by!(username: params.fetch(:username))
    else
      @user = current_user
    end
  end

  def authorize_user
    authorize @user
  end
end
