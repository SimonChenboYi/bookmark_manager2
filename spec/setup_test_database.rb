require 'pg'

p 'Setting up test database...'

def setup_test_database
  connection = PG.connect(dbname: 'bookmark_manager_test')

  # to clear the table -

  connection.exec('TRUNCATE bookmarks;')
end
