feature 'adding bookmarks' do
  scenario 'viewing added bookmark' do
    visit '/bookmarks/new'
    fill_in('url', with: 'http://www.reddit.com')
    fill_in('title', with: 'Reddit')
    click_button('add bookmark')
    expect(page).to have_link('Reddit', href: 'http://www.reddit.com')
  end
end
