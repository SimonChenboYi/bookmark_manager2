feature 'editing bookmarks' do
  scenario 'update the reddit bookmark to youtube page' do
    add_reddit_bookmark
    expect(page).to have_link('Reddit', href: 'http://www.reddit.com')
    click_button('update')
    fill_in('url', with: 'http://www.youtube.com')
    fill_in('title', with: 'Youtube')
    click_button('update')

    expect(page).to_not have_link('Reddit', href: 'http://www.reddit.com')
    expect(page).to have_link('Youtube', href: 'http://www.youtube.com')
  end

  scenario 'The bookmark must be a valid URL' do
    visit '/bookmarks/new'
    add_reddit_bookmark
    expect(page).to have_link('Reddit', href: 'http://www.reddit.com')
    click_button('update')
    fill_in('url', with: 'not a real bookmark')
    fill_in('title', with: 'Youtube')
    click_button('update')
    expect(page).not_to have_content 'not a real bookmark'
    expect(page).to have_content 'You must update with a valid URL.'
  end
end
