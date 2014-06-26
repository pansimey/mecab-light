require 'mkmf'

if mecab_dir = arg_config('--with-mecab-folder')
  sdk_dir = File.join(mecab_dir, 'sdk')
  bin_dir = File.join(mecab_dir, 'bin')
  if find_header('mecab.h', sdk_dir) && find_library('mecab', nil, bin_dir)
    create_makefile('mecab/light')
  end
else
  if have_header('mecab.h') && have_library('mecab')
    create_makefile('mecab/light')
  end
end
