class BaseController < ApplicationController
  
  def routing_error
    render text: "Page not found, sorry", status: :not_found
  end
end