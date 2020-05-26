module RubyFFI
  extend FFI::Library
  ffi_lib '../build/libpow.so'

  attach_function :mpz_pow, [ :int, :int ], :string
  attach_function :loop_pow, [ :int, :int ], :string
  attach_function :loop_pow_reduced, [ :int, :int ], :string
  attach_function :complete_calculation, [ :int, :int, :int, :int ], :string
end
