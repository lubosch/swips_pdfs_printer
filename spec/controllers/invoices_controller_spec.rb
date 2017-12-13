require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do

  describe '.show' do
    subject { get :show, params: { id: invoice.auth_token } }
    let(:invoice) { create(:invoice) }

    it 'shows 404 if exists' do
      response = get :show, params: { id: '443983' }
      expect(response.response_code).to eq 404
    end

    it 'sends file if exists' do
      expect(subject.response_code).to eq 200
      expect(subject.header['Content-Type']).to eq 'application/pdf'
    end
  end

  describe '.create' do
    subject { post :create, params: params }
    let(:params) do
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
    end

    it 'sends 400 if bad request' do
      expect(Invoices::PrinterInteractor).to receive(:call).and_return(instance_double(Invoices::PrinterInteractor, success: false))
      expect(subject.response_code).to eq 400
    end

    it 'sends invoice if good request' do
      response = subject
      expect(response.response_code).to eq 200
      expect(JSON.parse(response.body).keys).to contain_exactly('items', 'general_info', 'url', 'invoice_settings')
      expect(JSON.parse(response.body)['url']).to match %r(http://test\.host/invoices/\S+)
    end
  end

end
