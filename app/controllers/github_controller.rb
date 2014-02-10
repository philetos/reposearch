class GithubController < ApplicationController

  restrict_to_authenticated only: [ :search, :paginate ]

  def authorize
    github_client  = Github.new client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_CLIENT_SECRET"]
    address        = github_client.authorize_url  scope: 'repo'

    redirect_to address
  end

  def search
    github_client  = current_user_github_client

    if params[:query].present?
      @result = github_client.search.repos( q: params[:query][:text].presence, 
                                            sort: params[:query][:sort].presence, 
                                            order: params[:query][:order].presence )
    end

    respond_to do |format|
      format.js { render }
      format.html 
    end
  end

  def paginate
    github_client  = current_user_github_client
    @result        = github_client.get_request(params[:link])

    respond_to do |format|
      format.js { render action: :search, query: params[:query] }
    end
  end

  private
  
    def current_user_github_client
      Github.new oauth_token: current_user.github_access_token
    end
end
