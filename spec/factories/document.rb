FactoryGirl.define do
  factory :document do |f|
    f.mime_type "application/pdf"
    f.drm false
  end
end
