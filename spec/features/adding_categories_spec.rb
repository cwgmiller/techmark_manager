feature 'Adding categories' do

  scenario 'can add 1 category to a new link' do

    visit 'links/new'
    fill_in 'url', with: 'www.rubykoans.com'
    fill_in 'title', with: 'Ruby Koans'
    select 'Ruby', from: 'category'
    fill_in 'description', with: 'Useful for precourse'
    click_button 'Create link'
    link = Link.first
    expect(link.categories.map { |category| category.name} ).to include('Ruby')
    expect(page).to have_content('Useful for precourse')
  end

end
