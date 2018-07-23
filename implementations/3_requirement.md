## Requirements

1. When a user visits the index page, they are presented with a list of links, one for each document in the CMS

2. When a user clicks on a document link in the index, they should be taken to a page that displays the content of the file whose name was clicked.

3. When a user visits the path /history.txt, they will be presented with the content of the document history.txt.

4. The browser should render a text file as a plain text file.


## Implementation

* Update files.erb to include anchor links to each file

* Create get route for file names "/files/:filename"

* If file name doest not exist
  * Render error and redirect to main page
* If filename exists
  * Render the file as text in the browser
