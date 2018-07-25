## Requirements

1. When a user views the index page, they should see a "delete" button next to each document.

2. When a user clicks a "delete" button, the application should delete the appropriate document and display a message: "$FILENAME was deleted".

## Implementation

* Update `files.erb`
  * Each doc should have delete button next to the edit button

* create route for `post "/:filename/destroy"`
  * delete the file with the above filename
