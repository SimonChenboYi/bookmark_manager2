
def add_reddit_bookmark
  visit '/bookmarks/new'
  fill_in('url', with: 'http://www.reddit.com')
  fill_in('title', with: 'Reddit')
  click_button('add bookmark')
end 
