# encoding: utf-8
module Entity
  class User < Base
    expose :id, documentation: { type: "Integer", desc: "User ID" }
    expose :email, documentation: { type: "string", desc: "User email address" }
    expose :first_name, documentation: { type: "string", desc: "User first name" }
    expose :last_name, documentation: { type: "string", desc: "User last name" }

    with_options(format_with: :iso_timestamp) do
      expose :created_at, documentation: {type: "DateTime", desc: "User created at "}
      expose :updated_at, documentation: {type: "DateTime", desc: "User updated at "}
    end
  end
end