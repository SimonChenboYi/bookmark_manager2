feature 'Viewing bookmarks' do
  scenario 'visiting the index page' do
    visit('/')
    expect(page).to have_content "Bookmark Manager"
  end

  scenario 'viewing multiple bookmarks' do 
    visit '/bookmarks'
    expect(page).to have_content "www.google.com"
    expect(page).to have_content "www.youtube.com"
    expect(page).to have_content "www.reddit.com"
  end
end
