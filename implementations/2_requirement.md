## Requirements

When a user visits the home page, they should see a list of the documents in the CMS: history.txt, changes.txt and about.txt:

## Implementation

* Create 3 files under new `files` folder
  * about.txt
  * changes.txt
  * history.txt

* In `cms.rb` change route `get '/'`
  * read the file names of the files from the `files` folder into `@file_names` array
  * go to erb template `files.erb`

* Create a template for
  * access `@file_names` and display in an unordered list
