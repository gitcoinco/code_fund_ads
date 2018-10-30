# frozen_string_literal: true

require Rails.root.join("lib/extensions/kernel_then")
unless respond_to? :then
  Kernel.send :include, Extensions::KernelThen
end
