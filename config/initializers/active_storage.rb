ActiveStorage::Engine.config.active_storage.content_types_to_serve_as_binary.delete "image/svg+xml"
Rails.application.config.active_storage.queues.analysis = :default
Rails.application.config.active_storage.queues.purge = :default
