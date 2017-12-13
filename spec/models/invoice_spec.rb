# == Schema Information
#
# Table name: invoices
#
#  id                :integer          not null, primary key
#  items             :json
#  general_info      :json
#  auth_token        :string
#  invoice_settings  :json
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

RSpec.describe Invoice, type: :model do

end
