# README

## How to use authentication

### Login page should be routed to /login

Example:

```
<%= form_for(:session, url: login_path) do |f| %>

  <%= f.label :email %>
  <%= f.email_field :email, class: 'form-control' %>

  <%= f.label :password %>
  <%= f.password_field :password, class: 'form-control' %>

  <%= f.submit "Log in", class: "btn btn-primary" %>
<% end %>
```

### The user controller should use the log_in helper function to create a session for a new user

Example:

```
def create
  @user = User.new(user_params)
  if @user.save
    log_in @user #calls log_in method in helper
    redirect_to @user #goes to show action for this user
  else
    #failed to create user
    render 'new' #render registration page
  end
end
```

### Look at other methods in sessions helper to easily add access control to your controllers

```
# Returns the current logged-in user (if any).
def current_user
  @current_user ||= User.find_by(email_hash: session[:user_id])
end

# Returns true if the user is logged in, false otherwise.
def logged_in?
  !current_user.nil?
end
```


