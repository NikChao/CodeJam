class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
      render html: "Placeholder Homepage" #replace with actual html page
  end

end
