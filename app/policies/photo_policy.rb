class PhotoPolicy < ApplicationPolicy

  def show?
    user == record.owner || !record.owner.private? || record.owner.followers.include?(user)
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    user == record.owner
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
  
end
