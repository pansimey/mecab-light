module MeCab
  module Light
    module Binding
      extend FFI::Library
      ffi_lib 'mecab'
      attach_function :mecab_new2, [:string], :pointer
      attach_function :mecab_sparse_tostr, [:pointer, :string], :string
    end
  end
end
