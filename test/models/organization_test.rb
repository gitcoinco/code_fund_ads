# == Schema Information
#
# Table name: organizations
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  balance_cents    :integer          default(0), not null
#  balance_currency :string           default("USD"), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require "test_helper"

class OrganizationTest < ActiveSupport::TestCase
  test "balance calcs properly after several transactions of various types" do
    organization = organizations(:default)
    assert organization.balance == Monetize.parse("$0 USD")
    organization.organization_transactions.credits.create!(
      amount: Monetize.parse("$200 USD"),
      description: "Credit 1",
      reference: "Test",
      posted_at: Time.current,
    )
    organization.organization_transactions.debits.create!(
      amount: Monetize.parse("$50 USD"),
      description: "Debit 1",
      reference: "Test",
      posted_at: Time.current,
    )
    organization.organization_transactions.debits.create!(
      amount: Monetize.parse("$50 USD"),
      description: "Debit 2",
      reference: "Test",
      posted_at: Time.current,
    )
    organization.organization_transactions.debits.create!(
      amount: Monetize.parse("$50 USD"),
      description: "Debit 3",
      reference: "Test",
      posted_at: Time.current,
    )
    organization.organization_transactions.debits.create!(
      amount: Monetize.parse("$25 USD"),
      description: "Debit 4",
      reference: "Test",
      posted_at: Time.current,
    )
    organization.organization_transactions.credits.create!(
      amount: Monetize.parse("$75 USD"),
      description: "Credit 2",
      reference: "Test",
      posted_at: Time.current,
    )
    organization.recalculate_balance!
    assert organization.balance == Monetize.parse("$100 USD")
  end

  test "administrators" do
    organization = organizations(:default)
    assert organization.administrators
  end

  test "members" do
    organization = organizations(:default)
    assert organization.members
  end

  test "administrator must exist validation" do
    organization = organizations(:default)
    organization.administrators.delete_all
    assert_not organization.valid?
    assert_includes organization.errors.messages.to_s, "You need at least one"
  end
end
