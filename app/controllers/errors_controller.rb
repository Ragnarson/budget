class ErrorsController < ApplicationController
  def routing
    render action: "404", status: 404
  end
end
