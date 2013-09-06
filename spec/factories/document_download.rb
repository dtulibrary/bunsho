FactoryGirl.define do
  factory :document_download do |f|
    f.downloaded_at Time.now()
    f.downloaded_from "127.0.0.1"
    f.association :document
  end
end
