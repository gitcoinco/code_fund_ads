require Rails.root.join("lib/extensions/kernel_then")
require Rails.root.join("lib/extensions/active_storage_blob")
require Rails.root.join("lib/extensions/active_storage_attachment")

unless respond_to? :then
  Kernel.send :include, CodeFundAds::Extensions::KernelThen
end

Rails.application.config.after_initialize do
  ActiveStorage::Blob.send :include, CodeFundAds::Extensions::ActiveStorageBlob
  ActiveStorage::Attachment.send :include, CodeFundAds::Extensions::ActiveStorageAttachment
end
