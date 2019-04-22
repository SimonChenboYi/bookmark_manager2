require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      bookmarks = Bookmark.all
      expect(bookmarks).to include("www.google.com")
      expect(bookmarks).to include("www.youtube.com")
      expect(bookmarks).to include("www.reddit.com")
    end
  end
end
