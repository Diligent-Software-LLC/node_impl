require 'test_helper'

# NodeImplTest.
# @abstract
# Tests the Node class.
class NodeImplTest < Minitest::Test

  # test_version_declared().
  # @abstract
  # The version was declared.
  def test_version_declared()
    refute_nil(:: Node::VERSION)
  end

  # setup().
  # @abstract
  # Set fixtures.
  def setup()

    string          = 'test'
    @plain_instance = Node.new()
    @string_initd   = Node.new(nil, string, nil)
    @back_set_node  = Node.new(@string_initd, nil, nil)
    @front_set_node = Node.new(nil, nil, @string_initd)

  end

  # test_default_copy().
  # @abstract
  # The default instance's copy is a different object, and its attributes are
  # all nil.
  def test_default_copy()

    copy = @plain_instance.copy_constructor()
    refute_same(copy, @plain_instance)
    assert_nil(copy.back())
    assert_nil(copy.data())
    assert_nil(copy.front())

  end

  # test_default_type().
  # @abstract
  # The default instance's data type is NilClass.
  def test_default_type()
    expected_type = NilClass
    assert_same(@plain_instance.type(), expected_type)
  end

  # test_default_attr_eq().
  # @abstract
  # The default instance == the default instance copy.
  def test_default_attr_eq()
    copy = @plain_instance.copy_constructor()
    assert_equal(@plain_instance, copy)
  end

  # test_default_case_eq().
  # @abstract
  # The default instance is not the same as its copy.
  def test_default_case_eq()
    copy = @plain_instance.copy_constructor()
    refute_operator(@plain_instance, '===', copy)
  end

  # test_default_case_eq1().
  # @abstract
  # A reference is the same as itself.
  def test_default_case_eq1()
    other = @plain_instance
    assert_operator(other, '===', @plain_instance)
  end

  # test_default_inspect().
  # @abstract
  # The default inspection matches the expected string.
  def test_default_inspect()

    test_structure  = {back:  @plain_instance.back().inspect(),
                       data:  @plain_instance.data().inspect(),
                       front: @plain_instance.front().inspect()}
    expected_string = "#{@plain_instance.to_s()}: " +
        "#{test_structure.to_s()}"
    assert_equal(expected_string, @plain_instance.inspect())

  end

  # test_defaults_to_s().
  # @abstract
  # The default instance's to_s conversion equals the inspect return.
  def test_defaults_to_s()

    to_s_return    = @plain_instance.to_s()
    inspect_return = @plain_instance.inspect()
    refute_equal(inspect_return, to_s_return)

  end

  # test_data_value_gets().
  # @abstract
  # A data value initialized Node gets appropriately.
  def test_data_value_gets()
    value_node = Node.new(nil, 1, nil)
    assert_same(1, value_node.data())
  end

  # test_data_object_gets().
  # @abstract
  # A data object returns a copy.
  def test_data_object_gets()
    data_obj = 'test string'
    do_node  = Node.new(nil, data_obj, nil)
    refute_same(data_obj, do_node.data())
  end

  # test_copy_data_obj().
  # @abstract
  # The copy constructor copies the object value.
  def test_copy_data_obj()
    test_string = 'test'
    test_node   = Node.new(nil, test_string, nil)
    copy        = test_node.copy_constructor()
    refute_same(test_string, copy.data())
    assert_same(test_node.back(), copy.back())
    assert_same(test_node.front(), copy.front())
  end

  # test_back_copy().
  # @abstract
  # A back node-initialized Node copies the node's attribute values.
  def test_back_copy()
    copy = @back_set_node.copy_constructor()
    refute_same(@string_initd, copy.back())
    assert_equal(copy, @back_set_node)
  end

  # test_sub_default().
  # @abstract
  # Substituting a string initialized Node copies the string.
  def test_sub_default()
    pre_instance = @plain_instance
    pre_instance.substitute(@string_initd)
    assert_same(pre_instance, pre_instance)
  end

  # test_b_sub().
  # @abstract
  # Substituting a back initialized node copies the Node.
  def test_b_sub()
    pre_instance     = @plain_instance
    back_initialized = Node.new(@string_initd, 'test', nil)
    @plain_instance.substitute(back_initialized)
    assert_same(pre_instance, @plain_instance)
    assert_equal(back_initialized.back(), @plain_instance.back())
  end

  # test_f_sub().
  # @abstract
  # Substituting a front initialized node copies the Node.
  def test_f_sub()
    pre_instance      = @plain_instance
    front_initialized = Node.new(nil, 'test', @string_initd)
    @plain_instance.substitute(front_initialized)
    assert_same(pre_instance, @plain_instance)
    assert_equal(front_initialized.back(), @plain_instance.back())
  end

  # teardown().
  # @abstract
  # Cleanup.
  def teardown()
  end

end