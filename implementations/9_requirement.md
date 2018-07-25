## Requirements

When a user views the index page, they should see a link that says "New Document".
When a user clicks the "New Document" link, they should be taken to a page with a text input labeled "Add a new document:" and a submit button labeled "Create":

When a user enters a document name and clicks "Create", they should be redirected to the index page. The name they entered in the form should now appear in the file list. They should see a message that says "$FILENAME was created.", where $FILENAME is the name of the document just created:

If a user attempts to create a new document without a name, the form should be re-displayed and a message should say "A name is required."

## Implementation

* Update `files.erb`
  * At the very bottom link to New Document at `"/new"`

* create route for `get "/new"`
  * show `new_file.erb`

* create `new_file.erb`
  * form
    * label: Add a new document:
    * input: filename
    * button: Create

* create route for `post "/create"`
  * create the new file from the input box name
  * success message
  * redirect to `"/"`
