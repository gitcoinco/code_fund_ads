# Comments

## Adding comments to a resource

1. Add the following to the `Foo` model:

```ruby
acts_as_commentable
```

2. Create controller:

```sh
bin/rails g controller FooComments index --no-helper --skip-routes
```

3. Add route

```ruby
scope "/foos/:foo_id" do
  resources :foo_comments, only: [:index], path: "/comments"
end
```

4. Setup controller

```ruby
class FooCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_view!, only: :index
  before_action :set_foo, only: :index

  def index
    @comments = @foo.comment_threads.order(created_at: :desc)
  end

  private

  def set_foo
    @foo = if authorized_user.can_admin_system?
      Foo.find(params[:foo_id])
    else
      current_user.foos.find(params[:foo_id])
    end
  end

  def authorize_view!
    render_forbidden unless authorized_user.can_view_comments?
  end
end
```

5. Update the view

```erb
<%= render(PageComponent.new(subject: @foo, sidebar: true, tabs: true)) do |component| %>
  <% component.with(:header) do %>
    <%# Common header layout %>
  <% end %>
  <% component.with(:body) do %>
    <%= render(CommentsComponent.new(commentable: @foo, comments: @comments)) %>
  <% end %>
<% end %>
```

6. Update the `Foo` tabs and sidebar if needed

```erb
<%= tag.li (nav_item_link name: "Comments", path: foo_comments_path(subject)) if authorized_user.can_view_comments? %>
```

```erb
<%= active_link_to "Comments", foo_comments_path(foo), class: "menu-link", tabindex: -1, wrap_tag: :li, wrap_class: "menu-item" if authorized_user.can_view_comments? %>
```
