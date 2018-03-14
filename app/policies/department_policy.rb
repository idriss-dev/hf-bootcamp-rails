class DepartmentPolicy
  attr_reader :account, :record

  def initialize(account, record)
    @account = account
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
