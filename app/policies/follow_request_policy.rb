class FollowRequestPolicy < ApplicationPolicy

  def create?
    true
  end

  def update?
    user == record.sender || record.recipient
  end

  def destroy?
    update?
  end
end
