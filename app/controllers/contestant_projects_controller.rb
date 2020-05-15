class ContestantProjectsController < ApplicationController
  def create
    project = Project.find(params[:id])
    contestant = Contestant.find(params[:add_contestant_id])
    ContestantProject.create(contestant_id: contestant.id, project_id: project.id)
    redirect_to "/projects/#{params[:id]}"
  end
end
