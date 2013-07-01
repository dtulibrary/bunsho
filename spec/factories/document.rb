FactoryGirl.define do
  factory :document do |f|
    f.sequence(:uuid) { |n| "uuid-#{n}" }
    f.mime_type "application/pdf"
    f.available_count 5
    f.drm false
  end
end
