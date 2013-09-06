require 'spec_helper'

describe DocumentsController do

  describe "GET #show" do
    before :each do
      @document1 = FactoryGirl.create(:document)
      @document2 = FactoryGirl.create(:document)
    end

    after :each do
      @document1.destroy
      @document2.destroy
    end

    it "returns http success" do
      get :show, :uuid => @document1.uuid
      response.should be_success
    end

    it "returns failure" do
      get :show, :uuid => 'fake-uuid'
      response.should be_success
    end

    it "returns failure" do
      @document1.available_count = 0
      @document1.save!
      get :show, :uuid => @document1.uuid
      response.should be_success
      document = Document.find(@document1.id)
      document.available_count.should eq 0
    end

    describe "file" do
      before :each do
        save_file_for_document(@document1)
      end

      it "returns http success" do
        get :file, :uuid => @document1.uuid
        response.should be_success
        response.header['Content-Type'].should include 'application/pdf'
        document = Document.find(@document1.id)
        document.available_count.should eq (@document1.available_count - 1)
        document.document_downloads.count.should be 1
      end

      it "fails with 0 availabe" do
        @document1.available_count = 0
        @document1.save!
        get :file, :uuid => @document1.uuid
        response.should be_success
        response.header['Content-Type'].should include 'text/html'
        document = Document.find(@document1.id)
        document.available_count.should eq 0
      end

      it "fails with unknown uuid" do
        get :file, :uuid => 'fake-uuid'
        response.should be_success
        response.header['Content-Type'].should include 'text/html'
      end

    end

  end

  def save_file_for_document(document)
    @pdfdoc = File.read("spec/fixtures/document.pdf")
    File.open(document.file_name, 'wb') do |f|
      FileUtils.copy_stream(request.body, f)
    end
  end

end
