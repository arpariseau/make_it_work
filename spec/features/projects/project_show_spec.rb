require 'rails_helper'

RSpec.describe "Project show page", type: :feature do
  before :each do
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

    @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
    @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)

    ContestantProject.create(contestant_id: @kentaro.id, project_id: @lit_fit.id)
    ContestantProject.create(contestant_id: @erin.id, project_id: @lit_fit.id)

    visit("/projects/#{@lit_fit.id}")
  end

  it "shows the project's name, material and theme" do
    expect(page).to have_content(@lit_fit.name)
    expect(page).to have_content(@lit_fit.material)
    expect(page).to have_content(@furniture_challenge.theme)
  end

  it "shows the number of contestants on the project" do
    expect(page).to have_content("Number of Contestants: 2")
  end

  it "shows the average years of experience for the contestants that worked on the project" do
    expect(page).to have_content("Average Contestant Experience: #{23.0 / 2}")
  end
end

# As a visitor,
# When I visit a project's show page
# I see a form to add a contestant to this project
# When I fill out a field with an existing contestants id
# And hit "Add Contestant To Project"
# I'm taken back to the project's show page
# And I see that the number of contestants has increased by 1
# And when I visit the contestants index page
# I see that project listed under that contestant's name
