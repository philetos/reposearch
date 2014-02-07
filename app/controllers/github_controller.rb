class GithubController < ApplicationController
  restrict_to_authenticated only: [ :search ]

  def authorize
    github  = Github.new client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_CLIENT_SECRET"]
    address = github.authorize_url  scope: 'repo'
    redirect_to address
  end

  def search
    github  = Github.new oauth_token: current_user.github_access_token, auto_paginate: true

    if params[:query].present?
      @result = github.search.repos(q: params[:query][:text]).body
    end
  end
end
