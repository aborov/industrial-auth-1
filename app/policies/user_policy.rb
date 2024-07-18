class UserPolicy < ApplicationPolicy
  # attr_reader :user, :record

  def show?
    !record.private? || user == record || user.followers.include?(user)
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    user == current_user || user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    user == current_user || user.admin?
  end

  def feed?
    user == record
  end

  def discover?
    true
  end

  class Scope < Scope
    def resolve
      scope.where(private: false).or(scope.where(id: user.leaders.pluck(:id)))
    end
  end
end
