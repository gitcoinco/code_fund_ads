ActiveRecord::Type.register(:email_address, EmailAddress::EmailAddressType)
ActiveRecord::Type.register(:canonical_email_address, EmailAddress::CanonicalEmailAddressType)
