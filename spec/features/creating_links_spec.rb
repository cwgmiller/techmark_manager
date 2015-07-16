
feature 'Creating links' do

  scenario 'I can create new links' do
    visit '/links/new'
    fill_in 'url', with: 'www.codewars.com'
    fill_in 'title', with: 'Code Wars'
    select 'General', from: 'category'
    fill_in 'description', with: 'self-learning'
    click_button 'Create link'
    expect(current_path).to eq '/links'
    # expect(Link.count).to eq 1

    expect(page).to have_content('Code Wars')

  end
end

  # scenario 'there are no exisiting links in the test database at the start' do
  #   expect(Link.count).to eq 0
  # end
