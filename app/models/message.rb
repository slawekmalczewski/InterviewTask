class Message < ApplicationRecord
  has_one :clients
  has_one_attached :message_upload

  validate :only_json_file

  def get_upload_link
    Rails.application.routes.url_helpers.rails_blob_path(message_upload, only_path: true)
  end

  def get_file_path
    ActiveStorage::Blob.service.path_for(message_upload.key)
  end

  def retrieve_email_from_json
    self.message_upload.blob.filename
    file_to_parse = File.read(ActiveStorage::Blob.service.path_for(self.message_upload.key))
    data_hash = JSON.parse(file_to_parse)
    email = data_hash["email"]
  end

  def retrieve_first_name_from_json
    self.message_upload.blob.filename
    file_to_parse = File.read(ActiveStorage::Blob.service.path_for(self.message_upload.key))
    data_hash = JSON.parse(file_to_parse)
    first_name = data_hash["first_name"]
  end

  def retrieve_last_name_from_json
    self.message_upload.blob.filename
    file_to_parse = File.read(ActiveStorage::Blob.service.path_for(self.message_upload.key))
    data_hash = JSON.parse(file_to_parse)
    last_name = data_hash["last_name"]
  end

  def retrieve_amount_from_json
    self.message_upload.blob.filename
    file_to_parse = File.read(ActiveStorage::Blob.service.path_for(self.message_upload.key))
    data_hash = JSON.parse(file_to_parse)
    amount = data_hash["amount"]
  end

  private

  def only_json_file
    if message_upload.attached? && !message_upload.content_type.in?(%w(application/json))
        message_upload.purge # delete the uploaded file
        errors.add(:document, 'Must be a JSON file')
    end
  end

end
