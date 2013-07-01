require 'spec_helper'
include Devise::TestHelpers

describe Admin::DocumentsController do
  render_views

  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  after(:each) do
    @user.destroy
  end

  describe "GET #index" do
    it "renders the :index view" do
      FactoryGirl.create(:document)
      get :index
      response.status.should be(200)
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it "renders view" do
      get :show, id: FactoryGirl.create(:document)
      response.status.should be(200)
      response.should render_template :show
    end
  end

  describe "GET #new" do
    it "renders view" do
      get :new
      response.status.should be(200)
      response.should render_template :new
    end
  end

  describe "GET add_download" do
    it "renders view" do
      get :add_download, id: FactoryGirl.create(:document)
      response.status.should be(302)
    end
  end

end
