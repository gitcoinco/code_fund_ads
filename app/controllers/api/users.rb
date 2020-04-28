class API::Users < Grape::API
  include API::Defaults

  # Require administrator authentication
  before { administrator? } 

  resource :users do

    # index ......................................................

    desc "Return a list of users", { :entity => Entity::User }
    get '/' , http_codes: [
      [200, 'Ok', Entity::User]
    ] do
      users = User.all
      present users, with: Entity::User
    end
    
    # show ......................................................

    desc "Just a single email", { :entity => Entity::Email }
    params do
      requires :id, type: Integer
    end
    get ':id', http_codes: [
      [200, "Ok", Entity::Email]
    ] do
      email = current_user.emails.find(params[:id])
      present email, with: Entity::Email
    end

    # create ......................................................

    # desc "Create a new email", { :entity => Entity::Email }
    # params do
    #   requires :cc_addresses, type: Array, desc: ""
    #   requires :content, type: String, desc: ""
    #   requires :delivered_at, type: String, desc: ""
    #   requires :subject      :string           not null
    #   requires :to_addresses :text             default([]), is an Array
    #   requires :created_at   :datetime         not null
    #   requires :updated_at   :datetime         not null
    #   requires :message_id   :string           not null

    #   requires :title, type: String, desc: "The title for this todo"
    #   optional :description, type: String, desc: "The description for this todo"
    # end
    # post '/', http_codes: [
    #   [200, "Ok", Entity::Todo]
    # ] do
    #   todo = Todo.new
    #   todo.title = params[:title] if params[:title]
    #   todo.description = params[:description] if params[:description]
    #   todo.save 
      
    #   status 200
    #   present todo, with: Entity::Todo
    # end

  end
end