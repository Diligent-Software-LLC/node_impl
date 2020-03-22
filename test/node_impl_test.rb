require_relative 'test_helper'

# NodeImplTest.
# @abstract
# Tests the Node class.
class NodeImplTest < Minitest::Test

  # test_version_declared().
  # @abstract
  # The version was declared.
  def test_version_declared()
    refute_nil(::Node::VERSION)
  end

  # setup().
  # @abstract
  # Set fixtures.
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
    @inst_x1 = Node.new()
    @inst_x2 = Node.new(@inst_x1, @data_x1, @data_x2)
    @inst_x3 = Node.new(@data_x2, @data_x3, @inst_x1)
    b        = Node.new(Node.new(), @data_x4, @data_x2)
    f        = Node.new(@data_x2, @data_x1, Node.new())
    @inst_x4 = Node.new(b, 4, f)
    @inst_x5 = Node.new(@data_x2, @data_x5, @data_x2)
    @inst_x6 = Node.new(@data_x2, @data_x6, @data_x2)
    @inst_x7 = Node.new(nil, @data_x6, nil)
    @inst_x8 = Node.new(@inst_x7, nil, nil)
    @inst_x9 = Node.new(nil, nil, @inst_x7)

  end

  # type()

  # test_default_type().
  # @abstract
  # The default instance's data type is NilClass.
  def test_default_type()
    expected_type = NilClass
    assert_same(@inst_x1.type(), expected_type)
  end

  # ==(node = nil)

  # test_attr_eq_x2a_y2().
  # @abstract
  # An invalid node is unequal.
  def test_attr_eq_x2a_y2()

    x2a      = 'test'
    x1       = @inst_x1
    expected = false
    refute_operator(x1, '==', x2a)

  end

  # test_attr_eq_x2b_y1().
  # @abstract
  # Attributively equal nodes are equal.
  def test_attr_eq_x2b_y1()

    x2 = @inst_x2
    x1 = Node.new(@inst_x1, @data_x1, @data_x2)
    assert_operator(x1, '==', x2)

  end

  # test_default_attr_eq().
  # @abstract
  # The default instance == the default instance copy.
  def test_default_attr_eq()
    copy = @inst_x1.clone()
    assert_equal(@inst_x1, copy)
  end

  # to_s()

  # test_defaults_to_s().
  # @abstract
  # The default instance's to_s conversion equals the inspect return.
  def test_defaults_to_s()

    to_s_return    = @inst_x1.to_s()
    inspect_return = @inst_x1.inspect()
    refute_equal(inspect_return, to_s_return)

  end

  # data()

  # test_data_value_gets().
  # @abstract
  # A data value initialized Node gets appropriately.
  def test_data_value_gets()
    value_node = Node.new(nil, 1, nil)
    assert_same(1, value_node.data())
  end

  # test_data_object_gets().
  # @abstract
  # A data object returns a reference.
  def test_data_object_gets()

    data_obj = 'test string'
    do_node  = Node.new(nil, data_obj, nil)
    assert_same(data_obj, do_node.data())

  end

  # susbtitute(rhs)

  # test_sub_default().
  # @abstract
  # Substituting a string initialized Node copies the string.
  def test_sub_default()

    pre_instance = @inst_x1
    pre_instance.substitute(@inst_x7)
    assert_same(pre_instance, pre_instance)

  end

  # test_b_sub().
  # @abstract
  # Substituting a back initialized node copies the Node.
  def test_b_sub()

    pre_instance     = @inst_x1
    back_initialized = Node.new(@inst_x7, 'test', nil)
    @inst_x1.substitute(back_initialized)
    assert_same(pre_instance, @inst_x1)
    assert_equal(back_initialized.back(), @inst_x1.back())

  end

  # test_f_sub().
  # @abstract
  # Substituting a front initialized node copies the Node.
  def test_f_sub()

    pre_instance      = @inst_x1
    front_initialized = Node.new(nil, 'test', @inst_x7)
    @inst_x1.substitute(front_initialized)
    assert_same(pre_instance, @inst_x1)
    assert_equal(front_initialized.back(), @inst_x1.back())

  end

  # ===(rhs)

  # test_default_case_eq().
  # @abstract
  # The default instance is not the same as its copy.
  def test_default_case_eq()
    copy = @inst_x1.clone()
    refute_operator(@inst_x1, '===', copy)
  end

  # test_default_case_eq1().
  # @abstract
  # A reference is the same as itself.
  def test_default_case_eq1()
    other = @inst_x1
    assert_operator(other, '===', @inst_x1)
  end

  # inspect()

  # test_insp_x1_y1().
  # @abstract
  # A Node with nil back and front attributes returns an arrowless diagram.
  def test_insp_x1_y1()

    x1 = @inst_x1
    y1 = "|#{x1.to_s()}|\n|data: #{x1.data()}|"
    assert_equal(y1, x1.inspect())

  end

  # test_insp_x2_y2().
  # @abstract
  # A Node back and a nil front returns a back arrow diagram.
  def test_insp_x2_y2()

    x2       = @inst_x2
    y2       = x2.inspect()
    expected = "|#{x2.to_s()}|\n<--|data: #{x2.data()}|"
    assert_equal(expected, y2)

  end

  # test_insp_x3_y3().
  # @abstract
  # A nil back and a Node front returns a forward arrow diagram.
  def test_insp_x3_y3()

    x3       = @inst_x3
    expected = "|#{x3.to_s()}|-->\n|data: #{x3.data()}|"
    y3       = x3.inspect()
    assert_equal(expected, y3)

  end

  # test_insp_x4_y4().
  # @abstract
  # A doubly-linked node's diagram contains a forward arrow and backward arrow.
  def test_insp_x4_y4()

    x4       = @inst_x4
    expected = "|#{x4.to_s()}|-->\n<--|data: #{x4.data()}|"
    y4       = x4.inspect()
    assert_equal(expected, y4)

  end

  # back=(node = nil)

  # test_b_ass_x2a_y1().
  # @abstract
  # An invalid argument raises an ArgumentError. The back reference remains.
  def test_b_ass_x2a_y1()

    x2a        = @invalid_data1
    expected_b = @inst_x3.back()
    assert_raises(ArgumentError) {
      @inst_x3.back = x2a
    }
    assert_same(expected_b, @inst_x3.back())

  end

  # test_b_ass_x2b_y2().
  # @abstract
  # A valid Node becomes the back reference.
  def test_b_ass_x2b_y2()

    x2b     = @inst_x1
    x1      = @inst_x3
    x1.back = x2b
    assert_same(x2b, x1.back())

  end

  # data=(data = nil)

  # test_data_ass_x2a_y2().
  # @abstract
  # A valid data argument becomes the node's data.
  def test_data_ass_x2a_y2()

    x2a      = @data_x1
    x1       = @inst_x1
    expected = x2a
    x1.data  = x2a
    assert_same(expected, x1.data())

  end

  # test_data_ass_x2b_y1().
  # @abstract
  # An invalid data object raises an ArgumentError. The node's data remains.
  def test_data_ass_x2b_y1()

    x2b  = @invalid_data1
    node = @inst_x1
    y1   = node.data()
    assert_raises(ArgumentError) {
      node.data = x2b
    }
    expected = y1
    assert_same(expected, node.data())

  end

  # front=(node = nil)

  # test_f_ass_x2a_y1().
  # @abstract
  # An invalid argument raises an ArgumentError. The front reference remains.
  def test_f_ass_x2a_y1()

    x2a        = @invalid_data1
    expected_f = @inst_x3.front()
    assert_raises(ArgumentError) {
      @inst_x3.front = x2a
    }
    assert_same(expected_f, @inst_x3.front())

  end

  # test_f_ass_x2b_y2().
  # @abstract
  # A valid Node becomes the front reference.
  def test_f_ass_x2b_y2()

    x2b      = @inst_x1
    x1       = @inst_x3
    x1.front = x2b
    assert_same(x2b, x1.front())

  end

  # clone()

  # test_clone_x1_y1().
  # @abstract
  # A nil back and front node's copy is eql?() and not equal?().
  def test_clone_x1_y1()

    x       = @inst_x1
    x_back  = x.back()
    x_data  = x.data()
    x_front = x.front()
    y       = x.clone()
    y_back  = y.back()
    y_data  = y.data()
    y_front = y.front()
    assert_equal(x, y)
    refute_same(x, y)
    assert_same(x_back, y_back)
    assert_same(x_data, y_data)
    assert_same(x_front, y_front)

  end

  # test_clone_x2_y1().
  # @abstract
  # A nil front is attributively equal.
  def test_is_x2_y1()

    x  = @inst_x2
    y  = x.clone()
    xb = x.back()
    xd = x.data()
    xf = x.front()
    yb = y.back()
    yd = y.data()
    yf = y.front()
    assert_operator(xb, '==', yb)
    assert_same(xd, yd)
    assert_same(xf, yf)

  end

  # test_clone_x3_y1().
  # @abstract
  # A nil back attributively equals its copy.
  def test_clone_x3_y1()

    x  = @inst_x3
    y1 = x.clone()
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

  # test_clone_x4_y1().
  # @abstract
  # A doubly linked Node's copy is attributively equal.
  def test_clone_x4_y1()

    x  = @inst_x4
    y  = x.clone()
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

  # test_copy_data_obj().
  # @abstract
  # The copy constructor copies the object value.
  def test_copy_data_obj()

    test_string = 'test'
    test_node   = Node.new(nil, test_string, nil)
    copy        = test_node.clone()
    refute_same(test_string, copy.data())
    assert_same(test_node.back(), copy.back())
    assert_same(test_node.front(), copy.front())

  end

  # test_back_copy().
  # @abstract
  # A back node-initialized Node copies the node's attribute values.
  def test_back_copy()

    copy = @inst_x8.clone()
    refute_same(@inst_x7, copy.back())
    assert_equal(copy, @inst_x8)

  end

  # test_default_copy().
  # @abstract
  # The default instance's copy is a different object, and its attributes are
  # all nil.
  def test_default_copy()

    copy = @inst_x1.clone()
    refute_same(copy, @inst_x1)
    assert_nil(copy.back())
    assert_nil(copy.data())
    assert_nil(copy.front())

  end

  # teardown().
  # @abstract
  # Cleanup.
  def teardown()
  end

end