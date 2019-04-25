feature 'deleting bookmarks' do
  scenario 'deleting the reddit bookmark' do
    add_reddit_bookmark
    expect(page).to have_link('Reddit', href: 'http://www.reddit.com')
    click_button('delete')
    expect(page).to_not have_link('Reddit', href: 'http://www.reddit.com')
  end
end
