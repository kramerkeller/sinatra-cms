## Requirements

When a user attempts to view a document that does not exist, they should be redirected to the index page and shown the message: $DOCUMENT does not exist.

## Implementation

* Under in cms.rb  under `get /:filename`, if filename does not exist
  * redirect with error message
    * save error message to `session[:error]` (which means we have to enable sessions)

* To show an error message, we need to update `files.erb` to show an error if it exists in the `session[:error]` then delete it.
