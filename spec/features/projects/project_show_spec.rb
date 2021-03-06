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
    expect(page).to have_content("Average Contestant Experience: #{(8 + 15).to_f / 2}")
  end

  it "can add a contestant to the project" do
    jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)

    fill_in :add_contestant_id, with: jay.id
    click_button "Add Contestant To Project"

    expect(current_path).to eq("/projects/#{@lit_fit.id}")
    expect(page).to have_content("Number of Contestants: 3")

    visit "/contestants"
    within(".contestant-#{jay.id}") do
      expect(page).to have_content(@lit_fit.name)
    end
  end
end
