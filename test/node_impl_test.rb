require_relative 'test_helper'

# NodeImplTest.
# @class_description
#   Tests the Node implementation.
class NodeImplTest < Minitest::Test

  # Constants.
  CLASS          = Node
  ONE            = 1
  INTEGER_DATA   = 2
  NILCLASS_DATA   = nil
  SYMBOL_DATA    = :test_symbol
  TRUECLASS_DATA = true
  FALSECLASS_DATA = false
  TIME_DATA      = Time.now()
  STRING_DATA    = 'test'
  FLOAT_DATA      = 0.0
  INVALID_DATA   = {}

  # test_conf_doc_f_ex().
  # @description
  #   The .travis.yml, CODE_OF_CONDUCT.md, Gemfile, LICENSE.txt, README.md,
  #   and .yardopts files exist.
  def test_conf_doc_f_ex()

    assert_path_exists('.travis.yml')
    assert_path_exists('CODE_OF_CONDUCT.md')
    assert_path_exists('Gemfile')
    assert_path_exists('LICENSE.txt')
    assert_path_exists('README.md')
    assert_path_exists('.yardopts')

  end

  # test_version_declared().
  # @description
  #   The version was declared.
  def test_version_declared()
    refute_nil(CLASS::VERSION)
  end

  # setup().
  # @description
  #   Set fixtures.
  def setup()

    @node  = CLASS.new(NILCLASS_DATA, INTEGER_DATA, NILCLASS_DATA)
    @node1 = Node.new(NILCLASS_DATA, INTEGER_DATA, NILCLASS_DATA)
    @node2 = CLASS.new(NILCLASS_DATA, NILCLASS_DATA, NILCLASS_DATA)
    @node3 = CLASS.new(@node1, ONE, NILCLASS_DATA)
    @node4 = CLASS.new(NILCLASS_DATA, SYMBOL_DATA, @node1)
    b      = CLASS.new(CLASS.new(), TRUECLASS_DATA, NILCLASS_DATA)
    f      = CLASS.new(NILCLASS_DATA, ONE, CLASS.new())
    @node5 = CLASS.new(b, 4, f)

  end

  # shallow_clone()

  # test_sc_x1().
  # @description
  #   back and front are nil.
  def test_sc_x1()

    n   = Node.new(NILCLASS_DATA, INTEGER_DATA, NILCLASS_DATA)
    n_c = n.shallow_clone()
    assert_equal(n, n_c)

  end

  # test_sc_x2().
  # @description
  #   back or front is nil, and not both.
  def test_sc_x2()

    f_n = Node.new(NILCLASS_DATA, FLOAT_DATA, NILCLASS_DATA)
    n   = Node.new(NILCLASS_DATA, SYMBOL_DATA, f_n)
    n_c = n.shallow_clone()
    refute_equal(n, n_c)

  end

  # test_sc_x3().
  # @description
  #   back and front are Node instances.
  def test_sc_x3()

    b_n = Node.new(NILCLASS_DATA, FLOAT_DATA, NILCLASS_DATA)
    f_n = Node.new(NILCLASS_DATA, TRUECLASS_DATA, NILCLASS_DATA)
    n   = Node.new(b_n, FALSECLASS_DATA, f_n)
    n_c = n.shallow_clone()
    refute_equal(n, n_c)

  end

  # clone_df()

  # test_cdf_x1().
  # @description
  #   A Node back, nil data, and nil front.
  def test_cdf_x1()

    n       = Node.new(@node1, NILCLASS_DATA, NILCLASS_DATA)
    n_clone = n.clone_df()
    assert_equal(n_clone, n)

  end

  # test_cdf_x2().
  # @description
  #   A nil back, nil data, and Node front.
  def test_cdf_x2()

    n = Node.new(NILCLASS_DATA, NILCLASS_DATA, @node1)
    n_clone = n.clone_df()
    assert_equal(n, n_clone)

  end

  # test_cdf_x3().
  # @description
  #   A Node back, nil data, and Node front.
  def test_cdf_x3()

    node2   = Node.new(NILCLASS_DATA, NILCLASS_DATA, NILCLASS_DATA)
    n       = Node.new(@node1, NILCLASS_DATA, node2)
    n_clone = n.clone_df()
    assert_equal(n, n_clone)

  end

  # substitute(dti = nil)

  # test_substitute_x1().
  # @description
  #   An empty hash.
  def test_substitute_x1()

    assert_raises(DataError) {
      @node.substitute(INVALID_DATA)
    }

  end

  # test_substitute_x2().
  # @description
  #   A DataType type instance.
  def test_substitute_x2()
    @node.substitute(SYMBOL_DATA)
    assert_same(@node.d(), SYMBOL_DATA)
  end

  # b()

  # test_b_x1().
  # @description
  #   A nil back reference.
  def test_b_x1()
    assert_same(NILCLASS_DATA, @node1.b())
  end

  # test_b_x2().
  # @description
  #   A Node instance.
  def test_b_x2()

    n = Node.new(@node1, STRING_DATA, NILCLASS_DATA)
    assert_same(n.b(), @node1)
    assert_raises(FrozenError) {
      back_n = n.b()
      back_n.attach_back(n)
    }

  end

  # d()

  # test_d_x1().
  # @description
  #   A valid DataType type instance.
  def test_d_x1()

    n = Node.new(NILCLASS_DATA, TIME_DATA, NILCLASS_DATA)
    assert_same(n.d(), TIME_DATA)
    assert_predicate(n.d(), :frozen?)

  end

  # f()

  # test_f_x1().
  # @description
  #   front is nil.
  def test_f_x1()
    n = Node.new(NILCLASS_DATA, INTEGER_DATA, NILCLASS_DATA)
    assert_same(NILCLASS_DATA, n.f())
  end

  # test_f_x2().
  # @description
  #   front refers a Node instance.
  def test_f_x2()

    n = Node.new(NILCLASS_DATA, INTEGER_DATA, @node1)
    assert_same(n.f(), @node1)
    assert_raises(FrozenError) {
      front_n = n.f()
      front_n.attach_front(n)
    }

  end

  # type()

  # test_default_type().
  # @description
  #   The default instance's data type is NilClass.
  def test_default_type()
    expected_type = NilClass
    assert_same(@node2.type(), expected_type)
  end

  # ==(n = nil)

  # test_attr_eq_x2a_y2().
  # @description
  #   An invalid node is unequal.
  def test_attr_eq_x2a_y2()

    x2a = 'test'
    refute_operator(@node1, '==', x2a)

  end

  # test_attr_eq_x2b_y1().
  # @description
  #   Attributively equal nodes are equal.
  def test_attr_eq_x2b_y1()

    x2 = @node3
    x1 = CLASS.new(@node1, ONE, NILCLASS_DATA)
    assert_operator(x1, '==', x2)

  end

  # test_default_attr_eq().
  # @description
  #   The default instance == the default instance copy.
  def test_default_attr_eq()
    copy = @node1.clone_df()
    assert_equal(@node1, copy)
  end

  # data()

  # test_data_value_gets().
  # @description
  #   A data value initialized node gets appropriately.
  def test_data_value_gets()
    value_node = CLASS.new(NILCLASS_DATA, ONE, NILCLASS_DATA)
    assert_operator(ONE, 'equal?', value_node.d())
  end

  # test_data_object_gets().
  # @description
  #   A data instance returns a reference.
  def test_data_object_gets()

    data_obj = 'test string'
    do_node = CLASS.new(NILCLASS_DATA, data_obj, NILCLASS_DATA)
    assert_same(data_obj, do_node.d())

  end

  # ===(n = ni)

  # test_default_case_eq().
  # @description
  #   The default instance is not the same as its copy.
  def test_default_case_eq()
    copy = @node1.clone_df()
    refute_operator(@node1, '===', copy)
  end

  # test_default_case_eq1().
  # @description
  #   A reference is the same as itself.
  def test_default_case_eq1()
    other = @node1
    assert_operator(other, '===', @node1)
  end

  # inspect()

  # test_insp_x1_y1().
  # @description
  #   A Node with nil back and front attributes returns an arrowless diagram.
  def test_insp_x1_y1()

    x1        = @node1
    data_text = "data: #{x1.d()}"
    padding   = (26 - data_text.length()) / 2
    space     = ' ' * padding
    y1        = "| #{x1.to_s()} |\n| #{space}data: #{x1.d()}#{space}  |"
    assert_equal(y1, x1.inspect())

  end

  # test_insp_x2_y2().
  # @description
  #   A Node back and a nil front returns a back arrow diagram.
  def test_insp_x2_y2()

    x2            = @node3
    y2            = x2.inspect()
    arrow_length  = 3
    arrow_padding = ' ' * arrow_length
    data_text     = "data: #{x2.d()}"
    padding       = (26 - data_text.length()) / 2
    space         = ' ' * padding
    expected      = "#{arrow_padding}| #{x2.to_s()} |\n" +
        "<--| #{space}data: #{x2.d()}#{space}  |"
    assert_equal(expected, y2)

  end

  # test_insp_x3_y3().
  # @description
  #   A nil back and a Node front returns a forward arrow diagram.
  def test_insp_x3_y3()

    x3 = Node.new(NILCLASS_DATA, NILCLASS_DATA, @node1)
    data_text     = "data: #{x3.d()}"
    padding       = (26 - data_text.length()) / 2
    space         = ' ' * padding
    arrow_length  = 3
    arrow_padding = ' ' * arrow_length
    expected      = "| #{x3.to_s()} |-->\n| #{space}data: #{x3.d()}#{space} |" +
        "#{arrow_padding}"
    y3            = x3.inspect()
    assert_equal(expected, y3)

  end

  # test_insp_x4_y4().
  # @description
  #   A doubly-linked node's diagram contains a forward arrow and backward
  #   arrow.
  def test_insp_x4_y4()

    x4            = @node5
    data_text     = "data: #{x4.d()}"
    padding       = (26 - data_text.length()) / 2
    space         = ' ' * padding
    arrow_length  = 3
    arrow_padding = ' ' * arrow_length
    expected      = "#{arrow_padding}| #{x4.to_s()} |-->\n" +
        "<--| #{space}data: #{x4.d()}#{space}  |#{arrow_padding}"
    y4            = x4.inspect()
    assert_equal(expected, y4)

  end

  # attach_back(n = nil)

  # test_ab_x1().
  # @description
  #   A Node argument.
  def test_ab_x1()

    n   = Node.new(NILCLASS_DATA, INTEGER_DATA, NILCLASS_DATA)
    a_n = Node.new(NILCLASS_DATA, STRING_DATA, NILCLASS_DATA)
    n.attach_back(a_n)
    assert_same(a_n, n.b())

  end

  # test_ab_x2().
  # @description
  #   An argument type other than Node.
  def test_ab_x2()

    assert_raises(ArgumentError) {
      n = Node.new(NILCLASS_DATA, INTEGER_DATA, NILCLASS_DATA)
      n.attach_back(STRING_DATA)
    }

  end

  # attach_front(n = nil)

  # test_af_x1().
  # @description
  #   The argument's class is Node.
  def test_af_x1()

    a_n = Node.new(NILCLASS_DATA, TIME_DATA, NILCLASS_DATA)
    n   = Node.new(NILCLASS_DATA, SYMBOL_DATA, NILCLASS_DATA)
    n.attach_front(a_n)
    assert_same(a_n, n.f())

  end

  # test_af_x2().
  # @description
  #   The argument is not a Node.
  def test_af_x2()

    n = Node.new(NILCLASS_DATA, STRING_DATA, NILCLASS_DATA)
    assert_raises(ArgumentError) {
      n.attach_front(STRING_DATA)
    }

  end

  # detach_back()

  # test_detachb_x().
  # @description
  #   A Node.
  def test_detachb_x()
    @node.detach_back()
    assert_same(NILCLASS_DATA, @node.b())
  end

  # detach_front()

  # test_detachf_x().
  # @description
  #   A Node.
  def test_detachf_x()
    @node.detach_front()
    assert_same(NILCLASS_DATA, @node.f())
  end

  # adapt()

  # test_adapt_x().
  # @description
  #   self.
  def test_adapt_x()

    n_a = @node.adapt()
    assert_same(NodeAdapter, n_a.class())
    assert_same(n_a.back(), NILCLASS_DATA)
    assert_same(n_a.data(), INTEGER_DATA)
    assert_same(n_a.front(), NILCLASS_DATA)

  end

  # back=(node = nil)

  # test_b_ass_x2a_y1().
  # @description
  #   An invalid argument raises a NodeError. The back reference remains.
  def test_b_ass_x2a_y1()

    x2a = INVALID_DATA
    assert_raises(NodeError) {
      Node.new(x2a)
    }

  end

  # test_b_ass_x2b_y2().
  # @description
  #   A valid Node becomes the back reference.
  def test_b_ass_x2b_y2()
    @node1.attach_back(@node)
    assert_same(@node, @node1.b())
  end

  # data=(dti = nil)

  # test_data_ass_x2a_y2().
  # @description
  #   A valid data argument becomes the node's data.
  def test_data_ass_x2a_y2()

    x2a      = ONE
    expected = x2a
    @node1.substitute(x2a)
    assert_same(expected, @node1.d())

  end

  # test_data_ass_x2b_y1().
  # @description
  #   An invalid data object raises a DataError. The node's data remains.
  def test_data_ass_x2b_y1()

    x2b = INVALID_DATA
    assert_raises(DataError) {
      Node.new(nil, x2b, nil)
    }

  end

  # front=(node = nil)

  # test_f_ass_x2a_y1().
  # @description
  #   An invalid argument raises an NodeError. The front reference remains.
  def test_f_ass_x2a_y1()

    x2a = INVALID_DATA
    assert_raises(NodeError) {
      Node.new(nil, nil, x2a)
    }

  end

  # teardown().
  # @description
  #   Cleanup.
  def teardown()
  end

end
