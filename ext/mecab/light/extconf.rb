require 'mkmf'

begin
  require 'Win32API'

  dir_config('opt', 'c:\MeCab\sdk', 'c:\MeCab\bin')
rescue LoadError
end

if have_header('mecab.h') && have_library('mecab')
  create_makefile('mecab/light/binding')
else
  puts 'Install MeCab and give it another try.'
end
