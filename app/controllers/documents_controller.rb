class DocumentsController < ApplicationController
  def show
    @document = Document.find_by_uuid(params[:uuid])
  end

  def file
    @document = Document.find_by_uuid(params[:uuid])
    if @document
      if @document.can_download?
        @document.downloaded(request.ip)
        send_file(@document.file_name, :filename => "#{@document.uuid}.pdf",
          :type => "application/pdf")
      else
        flash[:alert] = t('bunsho.document.limit_reached')
      end
    else
      flash[:alert] = t('bunsho.document.unknown')
    end
  end

end
