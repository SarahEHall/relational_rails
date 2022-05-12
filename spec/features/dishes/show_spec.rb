require 'rails_helper'

RSpec.describe "Dishes show page", type: :feature do
  # As a visitor
  # When I visit '/child_table_name/:id'
  # Then I see the child with that id including the child's attributes:
  it 'can show details on a single dish from database' do
    @billy = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
    @flapjack = Restaurant.create!(name: "Flapjack's", open: true, guest_capacity: 105)
    @fry_pickle = @billy.dishes.create!(name: "Fried Pickles", in_season: true, cost: 8)
    @banana_pud = @flapjack.dishes.create!(name: "Banana Pudding", in_season: false, cost: 5)

    visit "/dishes/#{@fry_pickle.id}"

    expect(page).to have_content("Fried Pickles")
    expect(page).to have_content("Currently in season: true")
    expect(page).to have_content("Cost: $8")
    expect(page).to have_content("Added on: #{@fry_pickle.created_at}")
    expect(page).to have_content("Last updated at: #{@fry_pickle.updated_at}")

    visit "/dishes/#{@banana_pud.id}"

    expect(page).to have_content("Banana Pudding")
    expect(page).to have_content("Currently in season: false")
    expect(page).to have_content("Cost: $5")
    expect(page).to have_content("Added on: #{@banana_pud.created_at}")
    expect(page).to have_content("Last updated at: #{@banana_pud.updated_at}")
  end
end
