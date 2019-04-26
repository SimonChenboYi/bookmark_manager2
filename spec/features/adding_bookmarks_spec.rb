feature 'adding bookmarks' do
  scenario 'viewing added bookmark' do
    visit '/bookmarks/new'
    fill_in('url', with: 'http://www.reddit.com')
    fill_in('title', with: 'Reddit')
    click_button('add bookmark')
    expect(page).to have_link('Reddit', href: 'http://www.reddit.com')
  end

  scenario 'The bookmark must be a valid URL' do
    visit '/bookmarks/new'
    fill_in('url', with: 'not a real bookmark')
    click_button('add bookmark')
    expect(page).not_to have_content 'not a real bookmark'
    expect(page).to have_content 'You must submit a valid URL.'
  end
end
