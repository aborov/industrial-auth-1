class PhotoPolicy < ApplicationPolicy
  attr_reader :user, :photo

  def initialize(user, photo)
    @user = user
    @photo = photo
  end

  def show?
    @photo.owner == current_user ||
      !@photo.owner.private? ||
      @photo.owner.followers.include?(current_user)
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    @photo.owner == current_user
  end

  def edit?
    update?
  end

  def destroy?
    @photo.owner == current_user
  end

  class Scope < Scope
    def resolve
      scope.joins(:owner).where("users.private = ? OR users.id = ? OR users.id IN (?)", false, user.id, user.leaders)
    end
  end
end
