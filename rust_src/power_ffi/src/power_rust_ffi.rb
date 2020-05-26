require 'ffi'

module RustFFI
  extend FFI::Library
  ffi_lib File.join(__dir__, '..', 'target', 'debug', 'libpow.' + FFI::Platform::LIBSUFFIX)
  attach_function :power_class, %i[int32 int32 int32 int32], :double
end