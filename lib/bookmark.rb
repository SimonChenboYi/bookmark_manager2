require 'pg'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    connection = valid_connection

    result = connection.exec('SELECT * FROM bookmarks;')
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'],
                   title: bookmark['title'],
                   url: bookmark['url'])
    end
  end

  def self.create(url:, title:)
    connection = valid_connection

    result = connection.exec("INSERT INTO bookmarks (url, title)
                              VALUES('#{url}', '#{title}')
                              RETURNING id, url, title;")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'],
                 url: result[0]['url'])
  end

  def self.delete(id)
    connection = valid_connection
    connection.exec("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.update(id:, title:, url:)
    connection = valid_connection
    connection.exec("UPDATE bookmarks
      SET title = '#{title}', url = '#{url}' WHERE id = #{id};")
  end

  def self.valid_connection
    condition = (ENV['ENVIRONMENT'] == 'test')
    return PG.connect(dbname: 'bookmark_manager_test') if condition

    PG.connect(dbname: 'bookmark_manager')
  end
end
