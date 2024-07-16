class PhotoPolicy
  attr_reader :user, :photo

  def initialize(user, photo)
    @user = user
    @photo = photo
  end

  def show?
    user == current_user ||
     !user.private? || 
     user.followers.include?(current_user)
  end
end
