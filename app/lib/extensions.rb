module Extensions
end

Date.send :include, Extensions::DateHelpers
ActiveStorage::Blob.send :include, Extensions::ActiveStorageBlob
ActiveStorage::Attachment.send :include, Extensions::ActiveStorageAttachment
