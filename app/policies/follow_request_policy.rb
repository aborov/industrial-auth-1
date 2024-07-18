class FollowRequestPolicy < ApplicationPolicy
  def index?
    user == record.recipient || user == record.sender
  end

  def create?
    user != record.recipient
  end

  def destroy?
    user == record.sender || user == record.recipient
  end

  class Scope < Scope
    def resolve
      scope.where({ :recipient_id => user.id }).or(scope.where({ :sender_id => user.id }))
    end
  end
end
