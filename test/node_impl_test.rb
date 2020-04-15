require_relative 'test_helper'

# NodeImplTest.
# @class_description
#   Tests the Node implementation.
class NodeImplTest < Minitest::Test

  # Constants.
  CLASS          = Node
  ONE            = 1
  INTEGER_DATA   = 2
  NIL_DATA       = nil
  SYMBOL_DATA    = :test_symbol
  TRUECLASS_DATA = true
  TIME_DATA      = Time.now()
  STRING_DATA    = 'test'
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

    @node1 = Node.new(NIL_DATA, INTEGER_DATA, NIL_DATA)
    @node2 = CLASS.new(NIL_DATA, NIL_DATA, NIL_DATA)
    @node3 = CLASS.new(@node1, ONE, NIL_DATA)
    @node4 = CLASS.new(NIL_DATA, SYMBOL_DATA, @node1)
    b      = CLASS.new(CLASS.new(), TRUECLASS_DATA, NIL_DATA)
    f      = CLASS.new(NIL_DATA, ONE, CLASS.new())
    @node5 = CLASS.new(b, 4, f)

  end

  # clone_df()

  # test_cdf_x1().
  # @description
  #   A Node back, nil data, and nil front.
  def test_cdf_x1()

    n       = Node.new(@node1, NIL_DATA, NIL_DATA)
    n_clone = n.clone_df()
    assert_equal(n_clone, n)

  end

  # test_cdf_x2().
  # @description
  #   A nil back, nil data, and Node front.
  def test_cdf_x2()

    n       = Node.new(NIL_DATA, NIL_DATA, @node1)
    n_clone = n.clone_df()
    assert_equal(n, n_clone)

  end

  # test_cdf_x3().
  # @description
  #   A Node back, nil data, and Node front.
  def test_cdf_x3()

    node2   = Node.new(NIL_DATA, NIL_DATA, NIL_DATA)
    n       = Node.new(@node1, NIL_DATA, node2)
    n_clone = n.clone_df()
    assert_equal(n, n_clone)

  end

  # substitute(rhs = nil)

  # test_sub_x1().
  # @description
  #   The argument is not a Node instance.
  def test_sub_x1()

    n = Node.new(NIL_DATA, INTEGER_DATA, NIL_DATA)
    assert_raises(NodeError) {
      n.substitute(SYMBOL_DATA)
    }

  end

  # test_sub_x2().
  # @description
  #   back is nil, data is nil, and front is a Node.
  def test_sub_x2()

    n = Node.new(NIL_DATA, NIL_DATA, @node1)
    @node1.substitute(n)
    assert_equal(@node1, n)

  end

  # test_sub_x3().
  # @description
  #   back is a Node, data is nil, and front is nil.
  def test_sub_x3()

    n = Node.new(@node1, NIL_DATA, NIL_DATA)
    @node1.substitute(n)
    assert_equal(@node1, n)

  end

  # test_sub_x4().
  # @description
  #   back is nil, data is nil, and front is nil.
  def test_sub_x4()
    @node1.substitute(@node1)
    assert_equal(@node1, @node1)
  end

  # test_sub_x5().
  # @description
  #   back is a Node, data is nil, and front is a Node.
  def test_sub_x5()

    f_n = Node.new(NIL_DATA, NIL_DATA, NIL_DATA)
    n   = Node.new(@node1, NIL_DATA, f_n)
    @node1.substitute(n)
    assert_equal(@node1, n)

  end

  # b()

  # test_b_x1().
  # @description
  #   A nil back reference.
  def test_b_x1()
    assert_same(NIL_DATA, @node1.b())
  end

  # test_b_x2().
  # @description
  #   A Node instance.
  def test_b_x2()

    n = Node.new(@node1, STRING_DATA, NIL_DATA)
    assert_same(n.b(), @node1)
    assert_raises(FrozenError) {
      back_n = n.b()
      back_n.substitute(n)
    }

  end

  # d()

  # test_d_x1().
  # @description
  #   A valid DataType type instance.
  def test_d_x1()

    n = Node.new(NIL_DATA, TIME_DATA, NIL_DATA)
    assert_same(n.d(), TIME_DATA)
    assert_predicate(n.d(), :frozen?)

  end

  # f()

  # test_f_x1().
  # @description
  #   front is nil.
  def test_f_x1()
    n = Node.new(NIL_DATA, INTEGER_DATA, NIL_DATA)
    assert_same(NIL_DATA, n.f())
  end

  # test_f_x2().
  # @description
  #   front refers a Node instance.
  def test_f_x2()

    n = Node.new(NIL_DATA, INTEGER_DATA, @node1)
    assert_same(n.f(), @node1)
    assert_raises(FrozenError) {
      front_n = n.f()
      front_n.substitute(n)
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
    x1 = CLASS.new(@node1, ONE, NIL_DATA)
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
    value_node = CLASS.new(NIL_DATA, ONE, NIL_DATA)
    assert_operator(ONE, 'equal?', value_node.d())
  end

  # test_data_object_gets().
  # @description
  #   A data instance returns a reference.
  def test_data_object_gets()

    data_obj = 'test string'
    do_node  = CLASS.new(NIL_DATA, data_obj, NIL_DATA)
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

    x3            = Node.new(NIL_DATA, NIL_DATA, @node1)
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

    x1    = @node1
    sub_n = Node.new(@node1, nil, nil)
    x1.substitute(sub_n)
    assert_same(@node1, x1.b())

  end

  # data=(dti = nil)

  # test_data_ass_x2a_y2().
  # @description
  #   A valid data argument becomes the node's data.
  def test_data_ass_x2a_y2()

    x2a      = ONE
    expected = x2a
    sub_n    = Node.new(nil, x2a, nil)
    @node1.substitute(sub_n)
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

  # test_f_ass_x2b_y2().
  # @description
  #   A valid Node becomes the front reference.
  def test_f_ass_x2b_y2()

    x1    = @node1
    sub_n = Node.new(nil, nil, @node2)
    x1.substitute(sub_n)
    assert_same(@node2, x1.f())

  end

  # teardown().
  # @description
  #   Cleanup.
  def teardown()
  end

end
