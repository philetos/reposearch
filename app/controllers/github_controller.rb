class GithubController < ApplicationController
  restrict_to_authenticated only: [ :search ]

  def authorize
    github  = Github.new client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_CLIENT_SECRET"]
    address = github.authorize_url  scope: 'repo'
    redirect_to address
  end

  def search
    github  = Github.new oauth_token: current_user.github_access_token

    if params[:query].present?
      @result = github.search.repos(q: params[:query][:text].presence, sort: params[:query][:sort].presence, order: params[:query][:order].presence)
    end

    respond_to do |format|
      format.js { render }
      format.html 
    end
  end
end
