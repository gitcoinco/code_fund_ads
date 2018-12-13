module Extensions
end

Kernel.send :include, Extensions::KernelHelpers unless respond_to? :then
Date.send :include, Extensions::DateHelpers
ActiveStorage::Blob.send :include, Extensions::ActiveStorageBlob
ActiveStorage::Attachment.send :include, Extensions::ActiveStorageAttachment
