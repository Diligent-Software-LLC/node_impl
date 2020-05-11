require_relative '../test_helper'

# KindHelperTest.
# @class_description
#   Tests the KindHelper module.
class KindHelperTest < Minitest::Test

  # Constants.
  NILCLASS_DATA = nil
  TEST_SYMBOL   = :test_symbol
  TEST_FLOAT    = 3.14

  # setup().
  # @description
  #   Sets the test fixtures.
  def setup()
    @node1 = Node.new(NILCLASS_DATA, TEST_SYMBOL, NILCLASS_DATA)
    @node2 = Node.new(NILCLASS_DATA, TEST_FLOAT, NILCLASS_DATA)
  end

  # kind().

  # test_k_x1().
  # @description
  #   A 'lone' Node.
  def test_k_x1()

    n        = Node.new(NILCLASS_DATA, TEST_SYMBOL, NILCLASS_DATA)
    expected = 'lone'.freeze()
    actual   = n.kind()
    assert_equal(expected, actual)

  end

  # test_k_x2().
  # @description
  #   A 'base' Node.
  def test_k_x2()

    n        = Node.new(NILCLASS_DATA, TEST_SYMBOL, @node1)
    expected = 'base'.freeze()
    actual   = n.kind()
    assert_equal(expected, actual)

  end

  # test_k_x3().
  # @description
  #   A 'common' Node.
  def test_k_x3()

    n        = Node.new(@node1, TEST_SYMBOL, @node2)
    expected = 'common'.freeze()
    actual   = n.kind()
    assert_equal(expected, actual)

  end

  # test_k_x4().
  # @description
  #   A 'pioneer' Node.
  def test_k_x4()

    n        = Node.new(@node1, TEST_SYMBOL, NILCLASS_DATA)
    expected = 'pioneer'.freeze()
    actual   = n.kind()
    assert_equal(expected, actual)

  end

  # lone().

  # test_l_x1().
  # @description
  #   A Node bearing no 'back' and 'front' Node references.
  def test_l_x1()
    n = Node.new(NILCLASS_DATA, TEST_SYMBOL, NILCLASS_DATA)
    assert_predicate(n, :lone)
  end

  # test_l_x2().
  # @description
  #   A Node bearing attachments.
  def test_l_x2()
    n = Node.new(NILCLASS_DATA, TEST_SYMBOL, @node1)
    refute_predicate(n, :lone)
  end

  # common().

  # test_c_x1().
  # @description
  #   A Node bearing 'front' and 'back' attachments.
  def test_c_x1()
    n = Node.new(@node1, TEST_SYMBOL, @node2)
    assert_predicate(n, :common)
  end

  # test_c_x2().
  # @description
  #   A Node bearing no backward or forward attachment.
  def test_c_x2()
    n = Node.new(@node1, TEST_SYMBOL, NILCLASS_DATA)
    refute_predicate(n, :common)
  end

  # base().

  # test_b_x1().
  # @description
  #   A Node bearing no 'back' attachment and a 'front' attachment.
  def test_b_x1()
    n = Node.new(NILCLASS_DATA, TEST_SYMBOL, @node1)
    assert_predicate(n, :base)
  end

  # test_b_x2().
  # @description
  #   A Node bearing a 'back' attachment or a Node bearing a 'back'
  #   attachment and a 'front' attachment.
  def test_b_x2()
    n = Node.new(@node1, TEST_SYMBOL, NILCLASS_DATA)
    refute_predicate(n, :base)
  end

  # pioneer().

  # test_p_x1().
  # @description
  #   A Node bearing a backward attachment and no forward attachment.
  def test_p_x1()
    n = Node.new(@node1, TEST_SYMBOL, NILCLASS_DATA)
    assert_predicate(n, :pioneer)
  end

  # test_p_x2().
  # @description
  #   A Node bearing no 'back' attachments or a Node bearing 'back' and
  #   'front' attachments.
  def test_p_x2()
    n = Node.new(NILCLASS_DATA, TEST_SYMBOL, @node2)
    refute_predicate(n, :pioneer)
  end

end