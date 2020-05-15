require 'rails_helper'

RSpec.describe "Project show page", type: :feature do
  it "shows the project's name, material and theme" do
    furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
    lit_fit = furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

    visit("/projects/#{lit_fit.id}")
    expect(page).to have_content(lit_fit.name)
    expect(page).to have_content(lit_fit.material)
    expect(page).to have_content(furniture_challenge.theme)
  end
end


# User Story 3 of 3
# As a visitor,
# When I visit a project's show page
# I see a count of the number of contestants on this project
# ​
# (e.g.    Litfit
#     Material: Lamp Shade
#   Challenge Theme: Apartment Furnishings
#   Number of Contestants: 3 )
