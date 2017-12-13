class Invoices::PrinterInteractor

  attr_accessor :invoice, :success

  def self.call(params)
    invoice_data = invoice_params(params)
    invoice_data[:items] = items(params)
    invoice = InvoicePrinter::Document.new(invoice_data.to_h.symbolize_keys)

    pdf = StringIO.new(InvoicePrinter.render(
      document: invoice,
      font: 'public/fonts/dejavu_font/DejaVuSerifCondensed.ttf'
    ))
    invoice = Invoice.new(general_info: invoice, items: items(params), invoice_settings: {})

    pdf.class.class_eval { attr_accessor :original_filename, :content_type }
    pdf.original_filename = 'invoice.pdf'
    pdf.content_type = 'application/pdf'
    invoice.file = pdf
    invoice.save
    return new(invoice, true)
  end

  def self.invoice_params(params)
    params.require(:invoice).permit(:number, :provider_name, :provider_tax_id, :provider_tax_id2, :provider_street,
                                    :provider_street_number, :provider_postcode, :provider_city, :provider_city_part,
                                    :provider_extra_address_line, :purchaser_name, :purchaser_tax_id, :purchaser_tax_id2,
                                    :purchaser_street, :purchaser_street_number, :purchaser_postcode, :purchaser_city,
                                    :purchaser_city_part, :purchaser_extra_address_line, :issue_date, :due_date, :subtotal,
                                    :tax, :tax2, :tax3, :total, :bank_account_number, :account_iban, :account_swift, :note)
  end

  def self.items(params)
    result = []
    params[:items].each do |_index, item_line|
      result << InvoicePrinter::Document::Item.new(item_line.permit(:name, :quantity, :unit, :price, :tax, :amount).to_h.symbolize_keys)
    end
    result
  end

  def initialize(invoice, success)
    @invoice = invoice
    @success = success
  end

end