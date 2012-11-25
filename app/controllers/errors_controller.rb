class ErrorsController < ApplicationController
  def routing
    render action: "404"
  end
end
