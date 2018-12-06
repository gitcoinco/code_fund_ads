module Extensions
end

Kernel.send :include, Extensions::KernelThen unless respond_to? :then
ActiveStorage::Blob.send :include, Extensions::ActiveStorageBlob
ActiveStorage::Attachment.send :include, Extensions::ActiveStorageAttachment