require 'spec_helper'

describe Document do
  it "has a valid factory" do
    FactoryGirl.build(:document).should be_valid
  end

  it "fails without uuid" do
    FactoryGirl.build(:document, :uuid => nil).should_not be_valid
  end

  it "fails without mime_type" do
    FactoryGirl.build(:document, :mime_type => nil).should_not be_valid
  end

  describe "available_count" do
    it "fails if not numeric" do
      FactoryGirl.build(:document,
        :available_count => "bar").should_not be_valid
    end

    it "works if numeric" do
      FactoryGirl.build(:document, :available_count => "10").should be_valid
    end
  end

  describe "downloaded_count" do
    it "fails if not numeric" do
      FactoryGirl.build(:document, :downloaded_count => "bar").should_not be_valid
    end

    it "works if numeric" do
      FactoryGirl.build(:document, :downloaded_count => "10").should be_valid
    end
  end

  it "fails without drm" do
    FactoryGirl.build(:document, :drm => nil).should_not be_valid
  end

  describe "add_available_count" do
    it "increases by 1" do
      document = FactoryGirl.build(:document)
      count = document.available_count
      document.add_available_count
      document.available_count.should eq (count + 1)
    end
  end

  it "deletes download with document" do
    download = FactoryGirl.create(:document_download)
    download.document.destroy
    Document.count.should eq 0
    DocumentDownload.count.should eq 0
  end

end
