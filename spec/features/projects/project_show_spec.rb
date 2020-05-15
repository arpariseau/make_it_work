require 'rails_helper'

RSpec.describe "Project show page", type: :feature do
  before :each do
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")
  end
  it "shows the project's name, material and theme" do
    visit("/projects/#{@lit_fit.id}")
    expect(page).to have_content(@lit_fit.name)
    expect(page).to have_content(@lit_fit.material)
    expect(page).to have_content(@furniture_challenge.theme)
  end
  it "shows the number of contestants on the project" do
    kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
    erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)

    ContestantProject.create(contestant_id: kentaro.id, project_id: @lit_fit.id)
    ContestantProject.create(contestant_id: erin.id, project_id: @lit_fit.id)

    visit("/projects/#{@lit_fit.id}")
    expect(page).to have_content("Number of Contestants: 2")
  end
end
