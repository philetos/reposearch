class PagesController < ApplicationController
  restrict_to_authenticated

  def home
  end
end
