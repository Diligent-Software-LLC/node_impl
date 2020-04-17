require_relative '../test_helper'

# StateHelperTest.
# @class_description
#   Tests the StateHelper module.
class StateHelperTest < Minitest::Test

  # Constants
  NILCLASS_DATA = nil
  INTEGER_DATA  = 5
  SYMBOL_DATA   = :test_symbol
  STRING_DATA   = 'test'

  # setup().
  # @description
  #   Set fixtures.
  def setup()
    @node = Node.new(NILCLASS_DATA, INTEGER_DATA, NILCLASS_DATA)
  end

  # back_attached()

  # test_ba_x1().
  # @description
  #   A nil back.
  def test_ba_x1()
    refute_predicate(@node, :back_attached)
  end

  # test_ba_x2().
  # @description
  #   A Node back.
  def test_bas_x2()
    n = Node.new(@node, NILCLASS_DATA, NILCLASS_DATA)
    assert_predicate(n, :back_attached)
  end

  # front_attached()

  # test_fa_x1().
  # @description
  #   front is nil.
  def test_fa_x1()
    refute_predicate(@node, :front_attached)
  end

  # test_fa_x2().
  # @description
  #   front is a Node instance.
  def test_fa_x2()
    n = Node.new(NILCLASS_DATA, INTEGER_DATA, @node)
    assert_predicate(n, :front_attached)
  end

  # no_attachments()

  # test_na_x1().
  # @description
  #   Both or one attribute is a Node instance.
  def test_na_x1()
    n = Node.new(NILCLASS_DATA, STRING_DATA, @node)
    refute_predicate(n, :no_attachments)
  end

  # test_na_x2().
  # @description
  #   back and front are Node instances.
  def test_na_x2()
    assert_predicate(@node, :no_attachments)
  end

  # empty()

  # test_empty_x1().
  # @description
  #   data is nil.
  def test_empty_x1()
    @node.substitute(NILCLASS_DATA)
    assert_predicate(@node, :empty)
  end

  # test_empty_x2().
  # @description
  #   data is a DataType type instance.
  def test_empty_x2()
    refute_predicate(@node, :empty)
  end

  # base()

  # test_basep_x1().
  # @description
  #   back is nil and front is a Node instance.
  def test_basep_x1()
    n = Node.new(NILCLASS_DATA, STRING_DATA, @node)
    assert_predicate(n, :base)
  end

  # test_basep_x2().
  # @description
  #   back is a Node.
  def test_basep_x2()
    n = Node.new(@node, NILCLASS_DATA, NILCLASS_DATA)
    refute_predicate(n, :base)
  end

  # pioneer()

  # test_pioneer_x1().
  # @description
  #   back is a Node and front is nil.
  def test_pioneer_x1()
    n = Node.new(@node, NILCLASS_DATA, NILCLASS_DATA)
    assert_predicate(n, :pioneer)
  end

  # test_pioneer_x2().
  # @description
  #   back is nil.
  def test_pioneer_x2()
    refute_predicate(@node, :pioneer)
  end

end