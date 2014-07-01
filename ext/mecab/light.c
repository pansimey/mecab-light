#include <ruby.h>
#include <ruby/encoding.h>
#include <mecab.h>

#define MECAB_LIGHT_MAJOR_VERSION 1
#define MECAB_LIGHT_MINOR_VERSION 0
#define MECAB_LIGHT_PATCH_VERSION 1

typedef struct {
  mecab_model_t* ptr;
} Model;

typedef struct {
  mecab_t* ptr;
} Tagger;

typedef struct {
  mecab_lattice_t* ptr;
  rb_encoding* enc;
} Lattice;

typedef struct {
  const mecab_node_t* ptr;
  rb_encoding* enc;
} Node;

typedef struct {
  const mecab_node_t* bos_node;
  rb_encoding* enc;
} Result;

static VALUE
name_space()
{
  VALUE rb_mMeCab = rb_define_module("MeCab");
  return rb_define_module_under(rb_mMeCab, "Light");
}

static void
model_free(Model* model)
{
  mecab_model_destroy(model->ptr);
  free(model);
}

static VALUE
model_alloc(VALUE klass)
{
  Model* model = ALLOC(Model);
  return Data_Wrap_Struct(klass, 0, model_free, model);
}

static void
tagger_free(Tagger* tagger)
{
  mecab_destroy(tagger->ptr);
  free(tagger);
}

static VALUE
tagger_alloc(VALUE klass)
{
  Tagger* tagger = ALLOC(Tagger);
  return Data_Wrap_Struct(klass, 0, tagger_free, tagger);
}

static void
lattice_free(Lattice* lattice)
{
  mecab_lattice_destroy(lattice->ptr);
  free(lattice);
}

static VALUE
lattice_alloc(VALUE klass)
{
  Lattice* lattice = ALLOC(Lattice);
  return Data_Wrap_Struct(klass, 0, lattice_free, lattice);
}

static void
node_free(Node* node)
{
  free(node);
}

static void
result_free(Result* result)
{
  free(result);
}

static VALUE
rb_model_initialize(VALUE self, VALUE arg)
{
  Model* model;

  Data_Get_Struct(self, Model, model);
  model->ptr = mecab_model_new2(RSTRING_PTR(arg));
  return Qnil;
}

static VALUE
rb_tagger_initialize(VALUE self, VALUE arg)
{
  Tagger* tagger;
  Model* model;
  VALUE class_of_arg, rb_cModel;

  Data_Get_Struct(self, Tagger, tagger);
  rb_cModel = rb_define_class_under(name_space(), "Model", rb_cObject);
  class_of_arg = CLASS_OF(arg);
  if (class_of_arg == rb_cString) {
    tagger->ptr = mecab_new2(RSTRING_PTR(arg));
  } else if (class_of_arg == rb_cModel) {
    Data_Get_Struct(arg, Model, model);
    tagger->ptr = mecab_model_new_tagger(model->ptr);
  } else {
    rb_raise(rb_eTypeError, "The argument should be String or MeCab::Light::Model");
  }
  return Qnil;
}

static VALUE
rb_tagger_parse(VALUE self, VALUE arg)
{
  Tagger* tagger;
  Lattice* lattice;
  Result* result = ALLOC(Result);
  VALUE class_of_arg, rb_cLattice, rb_cResult;

  Data_Get_Struct(self, Tagger, tagger);
  rb_cLattice = rb_define_class_under(name_space(), "Lattice", rb_cObject);
  class_of_arg = CLASS_OF(arg);
  if (class_of_arg == rb_cString) {
    result->bos_node = mecab_sparse_tonode(tagger->ptr, RSTRING_PTR(arg));
    result->enc = rb_enc_get(arg);
  } else if (class_of_arg == rb_cLattice) {
    Data_Get_Struct(arg, Lattice, lattice);
    mecab_parse_lattice(tagger->ptr, lattice->ptr);
    result->bos_node = mecab_lattice_get_bos_node(lattice->ptr);
    result->enc = lattice->enc;
  } else {
    rb_raise(rb_eTypeError, "The argument should be String or MeCab::Light::Lattice");
  }
  rb_cResult = rb_define_class_under(name_space(), "Result", rb_cObject);
  return Data_Wrap_Struct(rb_cResult, 0, result_free, result);
}

static VALUE
rb_lattice_initialize(VALUE self, VALUE rb_model)
{
  Lattice* lattice;
  Model* model;

  Data_Get_Struct(self, Lattice, lattice);
  Data_Get_Struct(rb_model, Model, model);
  lattice->ptr = mecab_model_new_lattice(model->ptr);
  return Qnil;
}

static VALUE
rb_lattice_set_sentence(VALUE self, VALUE str)
{
  Lattice* lattice;

  Data_Get_Struct(self, Lattice, lattice);
  mecab_lattice_set_sentence(lattice->ptr, RSTRING_PTR(str));
  lattice->enc = rb_enc_get(str);
  return str;
}

static VALUE
result_enum_length(VALUE self, VALUE args, VALUE eobj)
{
  return rb_funcall(self, rb_intern("count"), 0);
}

static VALUE
rb_result_each(VALUE self)
{
  Result* result;
  Node* node;
  mecab_node_t* m_node;
  VALUE rb_cNode;

  RETURN_SIZED_ENUMERATOR(self, 0, 0, result_enum_length);
  Data_Get_Struct(self, Result, result);
  m_node = result->bos_node->next;
  rb_cNode = rb_define_class_under(name_space(), "Node", rb_cObject);
  for (; m_node->next; m_node = m_node->next) {
    node = ALLOC(Node);
    node->ptr = m_node;
    node->enc = result->enc;
    rb_yield(Data_Wrap_Struct(rb_cNode, 0, node_free, node));
  }
  return self;
}

static VALUE
rb_node_get_surface(VALUE self)
{
  Node* node;
  VALUE surface;

  Data_Get_Struct(self, Node, node);
  surface = rb_str_new(node->ptr->surface, node->ptr->length);
  return rb_enc_associate(surface, node->enc);
}

static VALUE
rb_node_get_feature(VALUE self)
{
  Node* node;
  VALUE feature;

  Data_Get_Struct(self, Node, node);
  feature = rb_str_new2(node->ptr->feature);
  return rb_enc_associate(feature, node->enc);
}

void
Init_light()
{
  VALUE rb_cModel, rb_cLattice, rb_cTagger, rb_cNode, rb_cResult;

  rb_cModel = rb_define_class_under(name_space(), "Model", rb_cObject);
  rb_cTagger = rb_define_class_under(name_space(), "Tagger", rb_cObject);
  rb_cLattice = rb_define_class_under(name_space(), "Lattice", rb_cObject);
  rb_cNode = rb_define_class_under(name_space(), "Node", rb_cObject);
  rb_cResult = rb_define_class_under(name_space(), "Result", rb_cObject);
  rb_define_alloc_func(rb_cModel, model_alloc);
  rb_define_alloc_func(rb_cTagger, tagger_alloc);
  rb_define_alloc_func(rb_cLattice, lattice_alloc);
  rb_define_private_method(rb_cModel, "initialize", rb_model_initialize, 1);
  rb_define_private_method(rb_cTagger, "initialize", rb_tagger_initialize, 1);
  rb_define_private_method(rb_cLattice, "initialize", rb_lattice_initialize, 1);
  rb_define_method(rb_cTagger, "parse", rb_tagger_parse, 1);
  rb_define_method(rb_cLattice, "sentence=", rb_lattice_set_sentence, 1);
  rb_define_method(rb_cResult, "each", rb_result_each, 0);
  rb_define_method(rb_cNode, "surface", rb_node_get_surface, 0);
  rb_define_method(rb_cNode, "feature", rb_node_get_feature, 0);
  rb_include_module(rb_cResult, rb_mEnumerable);
}
