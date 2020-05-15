require 'rails_helper'

RSpec.describe "Contestant index page", type: :feature do
  it "shows the contestant's name and projects" do
    recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

    upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")

    jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)

    ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
    ContestantProject.create(contestant_id: kentaro.id, project_id: upholstery_tux.id)
    ContestantProject.create(contestant_id: kentaro.id, project_id: boardfit.id)

    visit("/contestants")

    within(".contestant-#{kentaro.id}") do
      expect(page).to have_content(kentaro.name)
      expect(page).to have_content(boardfit.name)
      expect(page).to have_content(upholstery_tux.name)
    end

    within(".contestant-#{jay.id}") do
      expect(page).to have_content(jay.name)
      expect(page).to have_content(news_chic.name)
    end
  end
end
