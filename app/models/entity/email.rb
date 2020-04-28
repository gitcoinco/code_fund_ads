# encoding: utf-8
module Entity
  class Email < Base
    expose :id, documentation: { type: "Integer", desc: "Email ID" }
    expose :message_id, documentation: { type: "string", desc: "Email Message ID" }
    expose :to_addresses, documentation: { type: "Array<String>", desc: "Email recipients (direct)" }
    expose :cc_addresses, documentation: { type: "Array<String>", desc: "Email recipients (cc)" }
    expose :from_address, documentation: { type: "string", desc: "Sender" }

    with_options(format_with: :iso_timestamp) do
      expose :created_at, documentation: {type: "DateTime", desc: "User created at "}
      expose :updated_at, documentation: {type: "DateTime", desc: "User updated at "}
    end
  end
end