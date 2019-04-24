class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true #anyone can see a post
  end

  def create?
    return true #anyone can create post
  end

  def update?
    record.user == user #only post creater can update
  end

  def destroy?
    record.user == user #only post create can destroy
  end
end
