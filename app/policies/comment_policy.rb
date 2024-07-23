class CommentPolicy < ApplicationPolicy

  def create?
    photo = Photo.find(record.photo_id)
    user == photo.owner || !photo.owner.private? || photo.owner.followers.include?(user)
  end

  def update?
    user == record.author
  end

  def destroy?
    update?
  end
end
