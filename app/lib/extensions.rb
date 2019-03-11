module Extensions
end

Date.send :include, Extensions::DateHelpers
Array.send :include, Extensions::ArrayHelpers
ActiveStorage::Blob.send :include, Extensions::ActiveStorageBlob
ActiveStorage::Attachment.send :include, Extensions::ActiveStorageAttachment
