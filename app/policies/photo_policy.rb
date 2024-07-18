class PhotoPolicy < ApplicationPolicy
  attr_reader :user, :photo

  def initialize(user, photo)
    @user = user
    @photo = photo
  end

  def show?
    @photo.owner == user || !@photo.owner.private? || @photo.owner.followers.include?(user)
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    @photo.owner == user
  end

  def edit?
    update?
  end

  def destroy?
    @photo.owner == user
  end

  class Scope < Scope
    def resolve
      scope.joins(:owner).where("users.private = ? OR users.id = ? OR users.id IN (?)", false, user.id, user.leaders.pluck(:id))
    end
  end
end
