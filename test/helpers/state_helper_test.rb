require_relative '../test_helper'

# StateHelperTest.
# @class_description
#   Tests the StateHelper module.
class StateHelperTest < Minitest::Test

  # Constants.
  NILCLASS_I = nil
  INTEGER_DATA  = 5
  TEST_SYMBOL   = :test_symbol
  TEST_FLOAT    = 3.14

  # setup().
  # @description
  #   Set fixtures.
  def setup()

    @node1 = Node.new(NILCLASS_I, INTEGER_DATA, NILCLASS_I)
    @node2 = Node.new(NILCLASS_I, TEST_SYMBOL, NILCLASS_I)
    @node3 = Node.new(NILCLASS_I, TEST_FLOAT, NILCLASS_I)

  end

  # back_attached().

  # test_ba_x1().
  # @description
  #   A nil back.
  def test_ba_x1()
    refute_predicate(@node1, :back_attached)
  end

  # test_ba_x2().
  # @description
  #   A Node back.
  def test_bas_x2()
    n = Node.new(@node1, NILCLASS_I, NILCLASS_I)
    assert_predicate(n, :back_attached)
  end

  # front_attached().

  # test_fa_x1().
  # @description
  #   front is nil.
  def test_fa_x1()
    refute_predicate(@node1, :front_attached)
  end

  # test_fa_x2().
  # @description
  #   front is a Node instance.
  def test_fa_x2()
    n = Node.new(NILCLASS_I, INTEGER_DATA, @node1)
    assert_predicate(n, :front_attached)
  end

  # no_attachments().

  # test_na_x1().
  # @description
  #   Both or one attribute is a Node instance.
  def test_na_x1()
    n = Node.new(NILCLASS_I, TEST_SYMBOL, @node1)
    refute_predicate(n, :no_attachments)
  end

  # test_na_x2().
  # @description
  #   back and front are Node instances.
  def test_na_x2()
    assert_predicate(@node1, :no_attachments)
  end

  # empty().

  # test_empty_x1().
  # @description
  #   data is nil.
  def test_empty_x1()
    @node1.data = NILCLASS_I
    assert_predicate(@node1, :empty)
  end

  # test_empty_x2().
  # @description
  #   data is a DataType type instance.
  def test_empty_x2()
    refute_predicate(@node1, :empty)
  end

  # both_attached().

  # test_botha_x1().
  # @description
  #   A Node bearing a 'back' and a 'front' attachment.
  def test_botha_x1()
    n = Node.new(@node2, TEST_SYMBOL, @node3)
    assert_predicate(n, :both_attached)
  end

  # test_botha_x2().
  # @description
  #   A Node bearing no 'back' attachment or no 'front' attachment.
  def test_botha_x2()
    n = Node.new(NILCLASS_I, TEST_SYMBOL, @node2)
    refute_predicate(n, :both_attached)
  end

end