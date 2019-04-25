feature 'editing bookmarks' do
  scenario 'update the reddit bookmark to youtube page' do
    add_reddit_bookmark
    expect(page).to have_link('Reddit', href: 'http://www.reddit.com')
    click_button('update')
    fill_in('url', with: 'http://www.youtube.com')
    fill_in('title', with: 'Youtube')
    click_button('update')

    expect(page).to_not have_link('Reddit', href: 'http://www.reddit.com')
    expect(page).to_not have_link('Youtube', href: 'http://www.youtube.com')
  end
end
