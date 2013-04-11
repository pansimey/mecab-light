require 'mkmf'

if have_header('mecab.h') && have_library('mecab')
  create_makefile('mecab/light/binding')
else
  puts 'Install MeCab and give it another try.'
end
