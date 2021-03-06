class SessionsController < ApplicationController
  
  before_filter :destroy_session, except: [ :create ]

  def new
  end

  def create   
    @user    = User.from_github(params[:code])
    @session = Challah::Session.create(@user, request)

    if @session.save
      redirect_to github_search_path
    else
      redirect_to root_path, alert: "Unable to authorize"
    end
  end

  def destroy
    redirect_to root_path
  end

  protected
    def destroy_session
      current_user_session.destroy
    end
end
