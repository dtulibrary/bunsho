require 'spec_helper'

describe Rest::DocumentsController do
  render_views
  include WebMock::API

  describe "GET #index" do
     it "should not route" do
       { :get => "/documents" }.should_not be_routable
     end
  end

  describe "GET #show" do
    before :each do
      @document1 = FactoryGirl.create(:document)
      @document2 = FactoryGirl.create(:document)
    end

    it "renders json" do
      get :show, uuid: @document1.uuid, :format => :json
      response.header['Content-Type'].should include 'application/json'
      response.body.should eq @document1.to_json
    end

    it "renders text" do
      get :show, uuid: @document1.uuid, :format => :text
      response.header['Content-Type'].should include 'text/plain'
      response.body.should eq 'http://test.host/documents/'+@document1.uuid
    end
  end

  describe "PUT #new" do
    before :all do
      @pdfdoc = File.read("spec/fixtures/document.pdf")
    end

    after :all do
      WebMock.reset!
    end

    it "creates document from url" do
      stub_request(:get, 'http://localhost/document').
        to_return(:status => 200, :body => @pdfdoc, :headers => {
          'Content-Type' => 'application/pdf' })
      get :url, :url => 'http://localhost/document', :format => :json
      response.should be_success
      document = Document.all.first
      document.mime_type.should eq 'application/pdf'
      document.destroy
    end

    it "creates document from request" do
      @request.env["CONTENT_TYPE"] = "application/pdf"
      post :create, :body => @pdf_document, :format => :json
      response.should be_success
      document = Document.all.first
      document.mime_type.should eq 'application/pdf'
      document.drm.should eq false
      document.destroy
    end

    it "creates drm document from request" do
      @request.env["CONTENT_TYPE"] = "application/pdf"
      post :create, :drm => 'true', :body => @pdf_document, :format => :json
      response.should be_success
      document = Document.all.first
      document.mime_type.should eq 'application/pdf'
      document.drm.should eq true
      document.destroy
    end

    it "fails to create document" do
      stub_request(:get, 'http://localhost/document').
        to_return(:status => 404, :headers => {})
      get :url, :url => 'http://localhost/document', :format => :json
      response.should_not be_success
    end

  end
end
