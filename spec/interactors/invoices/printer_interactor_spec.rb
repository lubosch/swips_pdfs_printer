require 'rails_helper'

RSpec.describe Invoices::PrinterInteractor, type: :interactor do
  subject { Invoices::PrinterInteractor.call(params) }
  let(:params) do
    ActionController::Parameters.new(
      {
        invoice: {
          provider_name: 'VEKTRA spol. s r.o.', provider_tax_id: 'ICO 31 591 892', provider_tax_id2: 'VAT SK2020439377',
          provider_street: 'Námestie slobody 8', provider_street_number: '3', provider_postcode: '034 01',
          provider_city: 'Ružomberok', provider_extra_address_line: 'Slovakia',
          number: 32432423, purchaser_name: 'John Oldman', purchaser_street: 'Old street, 4', purchaser_postcode: '02220',
          purchaser_city: 'Malinovo', purchaser_extra_address_line: 'Estonia', issue_date: '2015-03-04'.to_date,
          due_date: '2015-03-11'.to_date, tax: '20%', total: '30.0€',
          subtotal: '23.4€', bank_account_number: '0000000330984313', account_iban: 'SK6809000000000330984313',
          account_swift: 'GIBASKBXXXX', note: 'Paid on 2015-03-05'
        },
        'items': {
          '0' => {
            'name' => 'Premium Membership 3 Months', 'quantity': 1, 'price': '23.4€', 'tax': "20%"
          }
        }
      }
    )
  end

  describe '.call' do
    it 'creates invoice pdf' do
      expect(subject.success).to be_truthy
      expect(subject.invoice.file).to be_present
      expect(subject.invoice.file_file_name).to eq 'invoice.pdf'
      expect(subject.invoice.file_content_type).to eq 'application/pdf'
      expect(subject.invoice.items)
        .to eq([{
                  'name' => 'Premium Membership 3 Months', 'quantity' => '1', 'unit' => '', 'price' => '23.4€',
                  'tax' => '20%', 'tax2' => '', 'tax3' => '', 'amount' => ''
                }])
      expect(subject.invoice.invoice_settings).to eq({})
      expect(subject.invoice.file_file_size).to be > 20000
      expect(subject.invoice.general_info)
        .to eq({
                 'account_iban' => 'SK6809000000000330984313', 'account_swift' => 'GIBASKBXXXX',
                 'bank_account_number' => '0000000330984313', 'due_date' => '2015-03-11', 'issue_date' => '2015-03-04',
                 'items' =>
                   [{ 'name' => 'Premium Membership 3 Months', 'quantity' => '1', 'unit' => '', 'price' => '23.4€',
                      'tax' => '20%', 'tax2' => '', 'tax3' => '', 'amount' => '' }],
                 'note' => 'Paid on 2015-03-05', 'number' => '32432423',
                 'provider_city' => 'Ružomberok', 'provider_city_part' => '', 'provider_extra_address_line' => 'Slovakia',
                 'provider_name' => 'VEKTRA spol. s r.o.', 'provider_postcode' => '034 01', 'provider_street' => 'Námestie slobody 8',
                 'provider_street_number' => '3', 'provider_tax_id' => 'ICO 31 591 892', 'provider_tax_id2' => 'VAT SK2020439377',
                 'purchaser_city' => 'Malinovo', 'purchaser_city_part' => '', 'purchaser_extra_address_line' => 'Estonia',
                 'purchaser_name' => 'John Oldman', 'purchaser_postcode' => '02220', 'purchaser_street' => 'Old street, 4',
                 'purchaser_street_number' => '', 'purchaser_tax_id' => '', 'purchaser_tax_id2' => '',
                 'subtotal' => '23.4€', 'tax' => '20%', 'tax2' => '', 'tax3' => '', 'total' => '30.0€',
               })
    end
  end
end
