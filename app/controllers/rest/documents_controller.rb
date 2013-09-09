class Rest::DocumentsController < ApplicationController
  def show
    @doc = Document.where(:uuid => params[:uuid]).first
    respond_with_doc
  end

  def create
    @doc = Document.new_from_request(request, params['drm'])
    respond_with_save
  end

  def url
    @doc = Document.new_from_url(params['url'], params['drm'])
    respond_with_save
  end

  private

  def respond_with_save
    unless @doc && @doc.save
      flash[:alert] = "Unable to create document"
    end
    respond_with_doc
  end

  def respond_with_doc
    respond_to do |format|
      format.html { render }
      format.json { render :json => @doc, :status => @doc ? 200 : 406 }
      format.text { render :text =>
                    (@doc ? document_show_url(@doc.uuid) : ''),
                    :status => (@doc ? 200 : 406) }
    end
  end

end
