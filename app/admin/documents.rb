ActiveAdmin.register Document do
  menu :priority => 1

  actions :all, :except => :edit

  member_action :add_download, :method => :get do
    document = Document.find_by_id(params[:id])
    document.add_available_count
    document.save!
    redirect_to admin_document_path
  end

  action_item :only => :show do
    link_to I18n.t('bunsho.admin.document.add_download'),
      add_download_admin_document_path
  end
end
