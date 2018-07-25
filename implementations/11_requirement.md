## Requirements

#### Signing In and Out

1. When a signed-out user views the index page of the site, they should see a "Sign In" button.

2. When a user clicks the "Sign In" button, they should be taken to a new page with a sign in form. The form should contain a text input labeled "Username" and a password input labeled "Password". The form should also contain a submit button labeled "Sign In":

3. When a user enters the username "admin" and password "secret" into the sign in form and clicks the "Sign In" button, they should be signed in and redirected to the index page. A message should display that says "Welcome!":

4. When a user enters any other username and password into the sign in form and clicks the "Sign In" button, the sign in form should be redisplayed and an error message "Invalid Credentials" should be shown. The username they entered into the form should appear in the username input.

5. When a signed-in user views the index page, they should see a message at the bottom of the page that says "Signed in as $USERNAME.", followed by a button labeled "Sign Out".

6. When a signed-in user clicks this "Sign Out" button, they should be signed out of the application and redirected to the index page of the site. They should see a message that says "You have been signed out.".

## Implementation

* Update `"/"` route and `files.erb`
  * If session[:username] false or non existent
    * Create a sign in button that directs a user to a sign in form
  * If session[:username] true
    * show "Signed in as $USERNAME."
    * show a button labeled "Sign Out".

* create route for `get 'users/signin'`
  * Signin form action="users/" method="post"
    * label Username:
    * input username
    * label Password:
    * button Sign In "submit"

* create a route for `post 'users/`
  * check for username "admin"
  * check for password "secret"
  * if session[:username] true redirect to index
    * set user logged_in true to session
    * success message "Welcome!"
    * redirect "/"
  * if session[:username] not true
    * error message "Invalid Credentials"
    * reload signin with and include last username

* create route for `post 'users/signout'`
  * delete session[:username]
  * success message "You have been signed out.".
  * redirect "/"
