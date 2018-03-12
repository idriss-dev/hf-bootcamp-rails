class AccountPolicy
  attr_reader :account, :record

  def initialize(account, record)
    @account = account
  end

  def invite?
    binding.pry
    account.has_role? :admin
  end
end
