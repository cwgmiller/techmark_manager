
feature 'Viewing links' do

  scenario 'I can see existing links on the page' do
    Link.create(url: 'www.rubymonk.com', title: 'Ruby Monk', description: 'useful for basics', categories: [Category.first_or_create(name: 'ruby')])
    visit '/links'
    expect(page.status_code).to eq 200

    within 'ul#links' do
      expect(page).to have_content('Ruby Monk')
      expect(page).to have_content('www.rubymonk.com')
      expect(page).to have_content('ruby')
      expect(page).to have_content('useful for basics')
    end
  end

  scenario 'I can filter links by categories' do
    Link.create(url: 'www.rubymonk.com', title: 'Ruby Monk', description: 'useful fo basics', categories: [Category.first_or_create(name: 'ruby')])
    visit 'links/ruby'
    within 'ul#links' do
      expect(page).not_to have_content('www.javascriptissexy.com')
      expect(page).to have_content('www.rubymonk.com')
    end
  end

end
