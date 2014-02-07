# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  first_name          :string(255)
#  last_name           :string(255)
#  username            :string(255)
#  email               :string(255)
#  email_hash          :string(255)
#  crypted_password    :string(255)
#  persistence_token   :string(255)
#  api_key             :string(255)
#  role_id             :integer          default(0)
#  last_session_at     :datetime
#  last_session_ip     :string(255)
#  session_count       :integer          default(0)
#  failed_auth_count   :integer          default(0)
#  created_by          :integer          default(0)
#  updated_by          :integer          default(0)
#  created_at          :datetime
#  updated_at          :datetime
#  active              :boolean          default(TRUE)
#  github_access_token :string(255)
#

class User < ActiveRecord::Base

  challah_user

  def self.from_github(authorization_code)
    github = Github.new client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_CLIENT_SECRET"]
    access_token = github.get_token(authorization_code).token

    where(github_access_token: access_token).first || create_from_github(access_token)
  end

  def self.create_from_github(access_token)
    github = Github.new client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_CLIENT_SECRET"]
    github.oauth_token = access_token
    github_user = github.users.get

    @user = where(username: github_user["login"]).first

    if @user.present?
      @user.github_access_token      = access_token
      @user.save
    else
      create! do |user|
        user = set_first_and_last_name(user, github_user["name"])

        user.username               = github_user["login"]
        user.email                  = github_user["email"]
        user.password               = Challah::Random.token(10)
        user.password_confirmation  = user.password
        user.github_access_token    = access_token

        @user = user
      end
    end

    @user
  end

  private
    def self.set_first_and_last_name(user, full_name)
      name_array = full_name.split[0...3]

      case name_array.count
        when 1
          user.first_name = name_array[0]
          user.last_name  = name_array[0]
        when 2
          user.first_name = name_array[0]
          user.last_name  = name_array[1]
        when 3
          user.first_name = name_array[0]
          user.last_name  = name_array[2]
      end

      user
    end
end
