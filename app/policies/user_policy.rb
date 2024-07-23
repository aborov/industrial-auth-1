class UserPolicy < ApplicationPolicy

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    user == record
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def feed?
    true
  end

  def discover?
    true
  end

  def view_photos?
    !record.private? || user == record || record.followers.include?(user)
  end

  def liked?
    view_photos?
  end
end
