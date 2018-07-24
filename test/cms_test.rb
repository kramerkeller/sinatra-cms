ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use!
require "rack/test"

require_relative "../cms"

class CmsTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get "/"
    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "about.md"
    assert_includes last_response.body, "changes.txt"
    assert_includes last_response.body, "history.txt"
  end

  def test_viewing_text_document
    get "/history.txt"
    assert_equal 200, last_response.status
    assert_equal "text/plain", last_response["Content-Type"]
    assert_includes last_response.body, "1993 - Yukihiro Matsumoto dreams up Ruby."
  end

  def test_non_existent_file
    get "/notafile.ext"
    assert_equal 302, last_response.status

    get last_response["Location"]

    assert_equal 200, last_response.status
    assert_includes last_response.body, "notafile.ext does not exist"
  end

  def test_viewing_markdown_file
    get "/about.md"
    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "<h1>Ruby is...</h1>"
  end

  def test_editing_file
    get "/changes.txt/edit"
    assert_equal 200, last_response.status
    assert_includes last_response.body, "Edit content of changes.txt:"
    assert_includes last_response.body, "<textarea"
    assert_includes last_response.body, %q(<input type="submit")
  end

  def test_updating_document
    post "/changes.txt", content: "new content"

    assert_equal 302, last_response.status

    get last_response["Location"]

    assert_includes last_response.body, "changes.txt has been updated"

    get "/changes.txt"
    assert_equal 200, last_response.status
    assert_includes last_response.body, "new content"
  end
end
