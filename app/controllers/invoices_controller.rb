class InvoicesController < ApplicationController

  def show
    @invoice = Invoice.find_by_auth_token(params[:id])
    if @invoice
      send_file @invoice.file.path,
                filename: @invoice.file_file_name,
                type: @invoice.file_content_type,
                disposition: 'inline'
    else
      render_404
    end
  end

  def create
    invoice_result = Invoices::PrinterInteractor.call(params)
    if invoice_result.success
      invoice = invoice_result.invoice
      json_response invoice.as_json(only: [:general_info, :items, :invoice_settings])
                      .merge({ url: "#{request.base_url}#{invoice_path(invoice.auth_token)}" })
    else
      render_400
    end
  end


end