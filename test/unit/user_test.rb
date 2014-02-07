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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
