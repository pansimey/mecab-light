#include <ruby.h>
#include <ruby/encoding.h>
#include <mecab.h>

typedef struct {
  mecab_t* ptr;
} MeCab;

static VALUE
mecab_alloc(VALUE klass)
{
  MeCab* mecab = ALLOC(MeCab);
  return Data_Wrap_Struct(klass, 0, 0, mecab);
}

static VALUE
rb_mecab_initialize(VALUE self, VALUE arg)
{
  MeCab* mecab;

  Data_Get_Struct(self, MeCab, mecab);
  mecab->ptr = mecab_new2(RSTRING_PTR(arg));
  return Qnil;
}

static VALUE
rb_mecab_parse_to_s(VALUE self, VALUE str)
{
  MeCab* mecab;
  const char* result;
  rb_encoding* enc;

  Data_Get_Struct(self, MeCab, mecab);
  enc = rb_enc_get(str);
  result = mecab_sparse_tostr(mecab->ptr, RSTRING_PTR(str));
  return rb_enc_associate(rb_str_new2(result), enc);
}

void
Init_binding()
{
  VALUE rb_mMeCab, rb_mLight, rb_cBinding;

  rb_mMeCab = rb_define_module("MeCab");
  rb_mLight = rb_define_module_under(rb_mMeCab, "Light");
  rb_cBinding = rb_define_class_under(rb_mLight, "Binding", rb_cObject);
  rb_define_alloc_func(rb_cBinding, mecab_alloc);
  rb_define_private_method(rb_cBinding, "initialize", rb_mecab_initialize, 1);
  rb_define_method(rb_cBinding, "parse_to_s", rb_mecab_parse_to_s, 1);
}
