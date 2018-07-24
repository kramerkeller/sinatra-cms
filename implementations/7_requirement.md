## Requirements

1. When a user views the index page, they should see an “Edit” link next to each document name.

2. When a user clicks an edit link, they should be taken to an edit page for the appropriate document.

3. When a user views the edit page for a document, that document's content should appear within a textarea:

4. When a user edits the document's content and clicks a “Save Changes” button, they are redirected to the index page and are shown a message: $FILENAME has been updated..

## Implementation

* Update `files.erb` with an edit link next to each document
  * Link should take user to `get ':filename/edit'``

* Create route at `get ':filename/edit'``
  * make `@contents` available to view

* Create `view/edit_file.erb`
    * paragraph header
      * "Edit contents of changes.txt:"
    * text area
      * `@contents` of doc
    * save changes submit button to `post :filename`

* Create route for `post :filename`
  * save doc changes
  * success message
  * redirect to index page
