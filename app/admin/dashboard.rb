ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel I18n.t("bunsho.admin.document.recent") do
          table do
            tr do
              th t("bunsho.admin.document.header.download")
              th t("bunsho.admin.document.header.uuid")
            end
            tr do
              Document.recent.map do |d|
                td d.downloaded_count
                td link_to d.uuid, admin_document_path(d)
              end
            end
          end
        end
      end
    end
  end # content
end
