class DepartmentPolicy
  attr_reader :account, :department

  def initialize(account, department)
    @account = account
    @department = department
  end

  def create?
    account.has_role? :admin
  end

  def update?
    account.has_role? :admin
  end

  def destroy?
    account.has_role? :admin
  end
end
