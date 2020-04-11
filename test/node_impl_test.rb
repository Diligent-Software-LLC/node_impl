require_relative 'test_helper'

# NodeImplTest.
# @class_description
#   Tests the Node implementation.
class NodeImplTest < Minitest::Test

  # Constants.
  CLASS = Node

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

    # data objects
    @data_x1       = 1
    @data_x2       = nil
    @data_x3       = :test_symbol
    @data_x4       = true
    @data_x5       = Time.now()
    @data_x6       = 'test'
    @invalid_data1 = {}

    # node instances
    @inst_x1 = CLASS.new()
    @inst_x2 = CLASS.new(@inst_x1, @data_x1, @data_x2)
    @inst_x3 = CLASS.new(@data_x2, @data_x3, @inst_x1)
    b        = CLASS.new(CLASS.new(), @data_x4, @data_x2)
    f        = CLASS.new(@data_x2, @data_x1, CLASS.new())
    @inst_x4 = CLASS.new(b, 4, f)
    @inst_x5 = CLASS.new(@data_x2, @data_x5, @data_x2)
    @inst_x6 = CLASS.new(@data_x2, @data_x6, @data_x2)
    @inst_x7 = CLASS.new(nil, @data_x6, nil)
    @inst_x8 = CLASS.new(@inst_x7, nil, nil)
    @inst_x9 = CLASS.new(nil, nil, @inst_x7)

  end

  # type()

  # test_default_type().
  # @description
  #   The default instance's data type is NilClass.
  def test_default_type()
    expected_type = NilClass
    assert_same(@inst_x1.type(), expected_type)
  end

  # ==(n = nil)

  # test_attr_eq_x2a_y2().
  # @description
  #   An invalid node is unequal.
  def test_attr_eq_x2a_y2()

    x2a = 'test'
    x1  = @inst_x1
    refute_operator(x1, '==', x2a)

  end

  # test_attr_eq_x2b_y1().
  # @description
  #   Attributively equal nodes are equal.
  def test_attr_eq_x2b_y1()

    x2 = @inst_x2
    x1 = CLASS.new(@inst_x1, @data_x1, @data_x2)
    assert_operator(x1, '==', x2)

  end

  # test_default_attr_eq().
  # @description
  #   The default instance == the default instance copy.
  def test_default_attr_eq()
    copy = @inst_x1.clone_df()
    assert_equal(@inst_x1, copy)
  end

  # to_s()

  # test_defaults_to_s().
  # @description
  #   The default instance's to_s conversion equals the inspect return.
  def test_defaults_to_s()

    to_s_return    = @inst_x1.to_s()
    inspect_return = @inst_x1.inspect()
    refute_equal(inspect_return, to_s_return)

  end

  # data()

  # test_data_value_gets().
  # @description
  #   A data value initialized node gets appropriately.
  def test_data_value_gets()
    value_node = CLASS.new(nil, 1, nil)
    assert_operator(1, 'equal?', value_node.data())
  end

  # test_data_object_gets().
  # @description
  #   A data instance returns a reference.
  def test_data_object_gets()

    data_obj = 'test string'
    do_node  = CLASS.new(nil, data_obj, nil)
    assert_same(data_obj, do_node.data())

  end

  # substitute(n = nil)

  # test_sub_default().
  # @description
  #   Substituting a string initialized Node copies the string.
  def test_sub_default()

    pre_instance = @inst_x1
    pre_instance.substitute(@inst_x7)
    assert_same(pre_instance, pre_instance)

  end

  # test_b_sub().
  # @description
  #   Substituting a back initialized node copies the Node.
  def test_b_sub()

    pre_instance     = @inst_x1
    back_initialized = CLASS.new(@inst_x7, 'test', nil)
    @inst_x1.substitute(back_initialized)
    assert_same(pre_instance, @inst_x1)
    assert_equal(back_initialized.back(), @inst_x1.back())

  end

  # test_f_sub().
  # @description
  #   Substituting a front initialized node copies the Node.
  def test_f_sub()

    pre_instance      = @inst_x1
    front_initialized = CLASS.new(nil, 'test', @inst_x7)
    @inst_x1.substitute(front_initialized)
    assert_same(pre_instance, @inst_x1)
    assert_equal(front_initialized.back(), @inst_x1.back())

  end

  # test_sub_inv().
  # @description
  #   Substituting an invalid node.
  def test_sub_inv()

    assert_raises(NodeError) {
      @inst_x6.substitute(@data_x6)
    }

  end

  # ===(n = ni)

  # test_default_case_eq().
  # @description
  #   The default instance is not the same as its copy.
  def test_default_case_eq()
    copy = @inst_x1.clone_df()
    refute_operator(@inst_x1, '===', copy)
  end

  # test_default_case_eq1().
  # @description
  #   A reference is the same as itself.
  def test_default_case_eq1()
    other = @inst_x1
    assert_operator(other, '===', @inst_x1)
  end

  # inspect()

  # test_insp_x1_y1().
  # @description
  #   A Node with nil back and front attributes returns an arrowless diagram.
  def test_insp_x1_y1()

    x1 = @inst_x1
    y1 = "| #{x1.to_s()} |\n|           data: #{x1.data()}           |"
    assert_equal(y1, x1.inspect())

  end

  # test_insp_x2_y2().
  # @description
  #   A Node back and a nil front returns a back arrow diagram.
  def test_insp_x2_y2()

    x2            = @inst_x2
    y2            = x2.inspect()
    arrow_length  = 3
    arrow_padding = ' ' * arrow_length
    expected      = "#{arrow_padding}| #{x2.to_s()} |\n" +
        "<--|          data: #{x2.data()}           |"
    assert_equal(expected, y2)

  end

  # test_insp_x3_y3().
  # @description
  #   A nil back and a Node front returns a forward arrow diagram.
  def test_insp_x3_y3()

    x3       = @inst_x3
    expected = "| #{x3.to_s()} |-->\n|     data: #{x3.data()}      |   "
    y3       = x3.inspect()
    assert_equal(expected, y3)

  end

  # test_insp_x4_y4().
  # @description
  #   A doubly-linked node's diagram contains a forward arrow and backward
  #   arrow.
  def test_insp_x4_y4()

    x4       = @inst_x4
    b_a_p    = '   '
    f_a_p    = '   '
    expected = "#{b_a_p}| #{x4.to_s()} |-->\n" +
        "<--|          data: #{x4.data()}           |#{f_a_p}"
    y4       = x4.inspect()
    assert_equal(expected, y4)

  end

  # back=(node = nil)

  # test_b_ass_x2a_y1().
  # @description
  #   An invalid argument raises a NodeError. The back reference remains.
  def test_b_ass_x2a_y1()

    x2a = @invalid_data1
    assert_raises(NodeError) {
      Node.new(x2a)
    }

  end

  # test_b_ass_x2b_y2().
  # @description
  #   A valid Node becomes the back reference.
  def test_b_ass_x2b_y2()

    x2b   = @inst_x1
    x1    = @inst_x3
    sub_n = Node.new(x2b, nil, nil)
    x1.substitute(sub_n)
    assert_same(x2b, x1.back())

  end

  # data=(data = nil)

  # test_data_ass_x2a_y2().
  # @description
  #   A valid data argument becomes the node's data.
  def test_data_ass_x2a_y2()

    x2a      = @data_x1
    x1       = @inst_x1
    expected = x2a
    sub_n    = Node.new(nil, x2a, nil)
    x1.substitute(sub_n)
    assert_same(expected, x1.data())

  end

  # test_data_ass_x2b_y1().
  # @description
  #   An invalid data object raises a DataError. The node's data remains.
  def test_data_ass_x2b_y1()

    x2b = @invalid_data1
    assert_raises(DataError) {
      Node.new(nil, x2b, nil)
    }

  end

  # front=(node = nil)

  # test_f_ass_x2a_y1().
  # @description
  #   An invalid argument raises an NodeError. The front reference remains.
  def test_f_ass_x2a_y1()

    x2a = @invalid_data1
    assert_raises(NodeError) {
      Node.new(nil, nil, x2a)
    }

  end

  # test_f_ass_x2b_y2().
  # @description
  #   A valid Node becomes the front reference.
  def test_f_ass_x2b_y2()

    x2b   = @inst_x1
    x1    = @inst_x3
    sub_n = Node.new(nil, nil, x2b)
    x1.substitute(sub_n)
    assert_same(x2b, x1.front())

  end

  # clone_df()

  # test_clone_df_x1_y1().
  # @description
  #   A nil back and front node's copy is eql?() and not equal?().
  def test_clone_df_x1_y1()

    x       = @inst_x1
    x_back  = x.back()
    x_data  = x.data()
    x_front = x.front()
    y       = x.clone_df()
    y_back  = y.back()
    y_data  = y.data()
    y_front = y.front()
    assert_operator(x, '==', y)
    refute_operator(x, '===', y)
    assert_operator(x_back, 'equal?', y_back)
    assert_operator(x_data, 'equal?', y_data)
    assert_operator(x_front, 'equal?', y_front)

  end

  # test_clone_df_x2_y1().
  # @description
  #   A nil front is attributively equal.
  def test_is_x2_y1()

    x  = @inst_x2
    y  = x.clone_df()
    xb = x.back()
    xd = x.data()
    xf = x.front()
    yb = y.back()
    yd = y.data()
    yf = y.front()
    assert_operator(xb, '==', yb)
    assert_operator(xd, 'equal?', yd)
    assert_operator(xf, 'equal?', yf)

  end

  # test_clone_df_x3_y1().
  # @description
  #   A nil back attributively equals its copy.
  def test_clone_df_x3_y1()

    x  = @inst_x3
    y1 = x.clone_df()
    xb = x.back()
    xd = x.data()
    xf = x.front()
    yb = y1.back()
    yd = y1.data()
    yf = y1.front()
    assert_operator(xb, '==', yb)
    assert_operator(xd, '==', yd)
    assert_operator(xf, '==', yf)

  end

  # test_clone_df_x4_y1().
  # @description
  #   A doubly linked Node's copy is attributively equal.
  def test_clone_df_x4_y1()

    x  = @inst_x4
    y  = x.clone_df()
    xb = x.back()
    xd = x.data()
    xf = x.front()
    yb = y.back()
    yd = y.data()
    yf = y.front()
    assert_operator(xb, '==', yb)
    assert_equal(xd, yd)
    assert_operator(xf, '==', yf)

  end

  # test_default_copy().
  # @description
  #   The default instance's copy is a different object, and its attributes are
  #   all nil.
  def test_default_copy()

    copy = @inst_x1.clone_df()
    refute_same(copy, @inst_x1)
    assert_nil(copy.back())
    assert_nil(copy.data())
    assert_nil(copy.front())

  end

  # teardown().
  # @description
  #   Cleanup.
  def teardown()
  end

end
