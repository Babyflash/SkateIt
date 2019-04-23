class SpotPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true #anyone can see a spot
  end

  def new?
    return true #anyone can create
  end

  def create?
    return true #anyone can create
  end

  def update?
    record.user == user #only spot creater can update
  end

  def destroy?
    record.user == user #only spot create can destroy
  end
end
