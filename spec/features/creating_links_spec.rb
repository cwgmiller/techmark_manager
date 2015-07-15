

feature 'creating links' do

  scenario 'I can create new links' do
    visit '/links/new'
    fill_in 'url', with 'www.codewars.com'
    fill_in 'title', with 'Code Wars'
    fill_in 'category', with 'General'
    fill_in 'topic', with 'tutorial'
    fill_in 'description', with 'self-learning'
    click_button 'Create link'

    expect(currrent_path).to eq '/links'

    within 'ul#links' do
      expect(page).to have_content('Code Wars')
    end
  end

  scenario 'there are no exisiting links in the test database at the start' do
    expect(Link.count).to eq 0
  end

end
