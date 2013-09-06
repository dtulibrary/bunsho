require 'spec_helper'

describe DocumentDownload do
  it "has a valid factory" do
    FactoryGirl.build(:document_download).should be_valid
  end

  it "fails without downloaded_at" do
    FactoryGirl.build(:document_download, :downloaded_at =>
      nil).should_not be_valid
  end

  describe "downloaded_at" do
    it "fails without invalid date" do
      FactoryGirl.build(:document_download, :downloaded_at =>
        "bogus").should_not be_valid
    end

    it "works with valid date" do
      FactoryGirl.build(:document_download, :downloaded_at =>
        "2013-01-01").should be_valid
    end
  end

  it "fails without downloaded_from" do
    FactoryGirl.build(:document_download, :downloaded_from =>
      nil).should_not be_valid
  end

  it "fails without document" do
    FactoryGirl.build(:document_download, :document => nil).should_not be_valid
  end

end
