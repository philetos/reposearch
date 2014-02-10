class GitHubber

  attr_accessor :access_token

  def initialize(authorization_code)
    @access_token = github_client.get_token(authorization_code).token
  end

  def user
    User.where(github_access_token: access_token).first || record_user
  end

  def record_user
    client             = github_client
    client.oauth_token = access_token
    github_user        = client.users.get

    @user = stored_user(github_user)

    if @user.present?
      @user.github_access_token = access_token
      @user.save
    else
      User.create! do |user|
        user                        = set_first_and_last_name(user, github_user["name"])
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

    def github_client
      Github.new client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_CLIENT_SECRET"]
    end

    def set_first_and_last_name(user, full_name)
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

    def stored_user(github_user)
      User.where(username: github_user["login"]).first
    end
end