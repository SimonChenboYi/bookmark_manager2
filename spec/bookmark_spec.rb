require 'bookmark'
require 'database_helpers'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      bookmark = Bookmark.create(url: 'http://www.makersacademy.com',
                                 title: 'Makers Academy')
      Bookmark.create(url: 'http://www.destroyallsoftware.com',
                      title: 'Destroy All Software')
      Bookmark.create(url: 'http://www.google.com', title: 'Google')

      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'http://www.reddit.com', title: 'Reddit')
      persisted_data = persisted_data(id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'Reddit'
      expect(bookmark.url).to eq 'http://www.reddit.com'
    end

    it 'does not create a new bookmark if the URL is not valid' do
      Bookmark.create(url: 'not a real bookmark', title: 'not a real bookmark')
      urls = Bookmark.all.map(&:url)
      expect(urls).not_to include 'not a real bookmark'
    end
  end

  describe '.delete' do
    it 'deletes a bookmark' do
      Bookmark.create(url: 'http://www.reddit.com', title: 'Reddit')
      bookmark = Bookmark.create(url: 'http://www.youtube.com',
                                 title: 'Youtube')
      Bookmark.create(url: 'http://www.facebook.com', title: 'Facebook')
      urls = Bookmark.all.map(&:url)
      expect(urls).to eq(['http://www.reddit.com', 'http://www.youtube.com',
                          'http://www.facebook.com'])
      Bookmark.delete(bookmark.id)
      urls = Bookmark.all.map(&:url)
      expect(urls).to eq(['http://www.reddit.com', 'http://www.facebook.com'])
    end
  end

  describe '.update' do
    it 'update a bookmark' do
      Bookmark.create(url: 'http://www.reddit.com', title: 'Reddit')
      bookmark = Bookmark.create(url: 'http://www.youtube.com',
                                 title: 'Youtube')
      Bookmark.create(url: 'http://www.facebook.com', title: 'Facebook')
      urls = Bookmark.all.map(&:url)
      expect(urls).to eq(['http://www.reddit.com', 'http://www.youtube.com',
                          'http://www.facebook.com'])
      Bookmark.update(id: bookmark.id, title: 'Instagram',
                      url: 'http://www.instagram.com')

      urls = Bookmark.all.map(&:url)
      expect(urls).to eq(['http://www.reddit.com', 'http://www.facebook.com',
                          'http://www.instagram.com'])
    end

    it 'does not create a new bookmark if the URL is not valid' do
      Bookmark.create(url: 'not a real bookmark', title: 'not a real bookmark')
      bookmark = Bookmark.create(url: 'http://www.youtube.com',
                                 title: 'Youtube')
      Bookmark.update(id: bookmark.id, title: 'Instagram',
                      url: 'http://www.instagram.com')
      urls = Bookmark.all.map(&:url)
      expect(urls).not_to include 'not a real bookmark'
    end
  end

  describe '.find' do
    it 'returns the requested bookmark object' do
      bookmark = Bookmark.create(title: 'Makers Academy',
                                 url: 'http://www.makersacademy.com')

      result = Bookmark.find(id: bookmark.id)

      expect(result).to be_a Bookmark
      expect(result.id).to eq bookmark.id
      expect(result.title).to eq 'Makers Academy'
      expect(result.url).to eq 'http://www.makersacademy.com'
    end
  end
end
