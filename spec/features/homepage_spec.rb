feature 'When accesing home page' do
  scenario 'can see greeting' do
    visit '/'
    expect(page).to have_content "Please sign up to use Chitter!"
  end
end
