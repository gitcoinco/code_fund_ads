module Extensions
end

Module.send :include, Extensions::ModuleHelpers
Date.send :include, Extensions::DateHelpers
ActiveStorage::Blob.send :include, Extensions::ActiveStorageBlob
ActiveStorage::Attachment.send :include, Extensions::ActiveStorageAttachment
