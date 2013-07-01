require 'spec_helper'

describe HomeController do
  render_views

  it "renders index page" do
    Rails.application.config.main_service_url = nil
    get :index
    response.status.should be (200)
    response.should render_template :index
  end

  it "redirects index page" do
    Rails.application.config.main_service_url = "http://localhost"
    get :index
    response.status.should be (302)
    response.should redirect_to 'http://localhost'
  end
end
