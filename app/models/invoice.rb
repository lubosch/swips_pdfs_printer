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

class Invoice < ApplicationRecord
  has_secure_token :auth_token

  has_attached_file :file
  validates_attachment_content_type :file, :content_type => "application/pdf"

end
