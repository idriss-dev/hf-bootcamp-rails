class OrganizationPolicy
  attr_reader :account, :organization

  def initialize(account, organization)
    @account = account
    @organization = organization
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
