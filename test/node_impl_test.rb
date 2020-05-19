require_relative 'test_helper'

# NodeImplTest.
# @class_description
#   Tests the Node implementation.
class NodeImplTest < Minitest::Test

  # Constants.
  CLASS          = Node
  ONE            = 1
  INTEGER_DATA   = 2
  NILCLASS_I   = nil
  TEST_SYMBOL    = :test_symbol
  TRUECLASS_DATA = true
  FALSECLASS_DATA = false
  TEST_FLOAT      = 3.14
  INVALID_DATA   = {}
  NODE1 = Node.new(NILCLASS_I, TEST_SYMBOL, NILCLASS_I)

  # test_conf_doc_f_ex().
  # @description
  #   The .travis.yml, CODE_OF_CONDUCT.md, Gemfile, LICENSE.txt, README.md,
  #   .yardopts, .gitignore, Changelog.md, CODE_OF_CONDUCT.md,
  #   node_impl.gemspec, Gemfile.lock, and Rakefile files exist.
  def test_conf_doc_f_ex()

    assert_path_exists('.travis.yml')
    assert_path_exists('CODE_OF_CONDUCT.md')
    assert_path_exists('Gemfile')
    assert_path_exists('LICENSE.txt')
    assert_path_exists('README.md')
    assert_path_exists('.yardopts')
    assert_path_exists('.gitignore')
    assert_path_exists('Changelog.md')
    assert_path_exists('CODE_OF_CONDUCT.md')
    assert_path_exists('node_impl.gemspec')
    assert_path_exists('Gemfile.lock')
    assert_path_exists('Rakefile')

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

    @node  = CLASS.new(NILCLASS_I, INTEGER_DATA, NILCLASS_I)
    @node1 = Node.new(NILCLASS_I, INTEGER_DATA, NILCLASS_I)
    @node2 = CLASS.new(NILCLASS_I, NILCLASS_I, NILCLASS_I)
    @node3 = CLASS.new(@node1, ONE, NILCLASS_I)
    @node4 = CLASS.new(NILCLASS_I, TEST_SYMBOL, @node1)
    b      = CLASS.new(CLASS.new(), TRUECLASS_DATA, NILCLASS_I)
    f      = CLASS.new(NILCLASS_I, ONE, CLASS.new())
    @node5 = CLASS.new(b, 4, f)
    @lone = Node.new(NILCLASS_I, TEST_SYMBOL, NILCLASS_I)
    @base = Node.new(NILCLASS_I, TEST_SYMBOL, @node1)
    @common = Node.new(@node1, TEST_SYMBOL, @node2)
    @pioneer = Node.new(@node1, TEST_SYMBOL, NILCLASS_I)

  end

  # shallow_clone().

  # test_sc_x1().
  # @description
  #   Either 'back' or 'front' is a Node.
  def test_sc_x1()

    clone = @base.shallow_clone()
    assert_equal(clone, @base)
    refute_same(clone, @base)

  end

  # test_sc_x2().
  # @description
  #   'back' and 'front' are nil.
  def test_sc_x2()

    clone = @lone.shallow_clone()
    assert_equal(clone, @lone)
    refute_same(clone, @lone)

  end

  # test_sc_x3().
  # @description
  #   A frozen Node.
  def test_sc_x3()

    frozen = Node.new(NILCLASS_I, TEST_FLOAT, NILCLASS_I)
    frozen.freeze()
    clone = frozen.shallow_clone()
    assert_equal(clone, frozen)
    refute_same(clone, frozen)
    assert_predicate(clone, :frozen?)

  end

  # clone_df().

  # test_cdf_x1().
  # @description
  #   self's 'back' or 'front' is a Node.
  def test_cdf_x1()

    clone = @pioneer.clone_df()
    refute_same(clone, @pioneer)
    refute_equal(clone, @pioneer)

  end

  # test_cdf_x2().
  # @description
  #   'back' and 'front' are nil.
  def test_cdf_x2()

    clone = @lone.clone_df()
    refute_same(clone, @lone)
    assert_equal(clone, @lone)

  end

  # test_cdf_x3().
  # @description
  #   'back' or 'front' is frozen.
  def test_cdf_x3()

    frozen_n = Node.new(NILCLASS_I, TEST_SYMBOL, NILCLASS_I)
    p = Node.new(frozen_n, TEST_SYMBOL, NILCLASS_I)
    clone = p.clone_df()
    refute_same(clone, p)
    refute_equal(clone, p)

  end

  # test_cdf_x4().
  # @description
  #   'back' and 'front' are nil. self is frozen.
  def test_cdf_x4()

    frozen_l = Node.new(NILCLASS_I, TEST_SYMBOL, NILCLASS_I).freeze()
    clone = frozen_l.clone_df()
    assert_predicate(clone, :frozen?)
    assert_equal(clone, frozen_l)

  end

  # test_cdf_x5().
  # @description
  #   'back' or 'front' is a Node. self is frozen.
  def test_cdf_x5()

    frozen_b = Node.new(NILCLASS_I, TEST_SYMBOL, @lone).freeze()
    clone = frozen_b.clone_df()
    refute_equal(clone, frozen_b)
    assert_raises(FrozenError) {
      clone.data = TEST_FLOAT
    }

  end

  # test_cdf_x6().
  # @description
  #   'back' or 'front' is frozen, and self is frozen.
  def test_cdf_x6()

    frozen_f = Node.new(NILCLASS_I, TEST_SYMBOL, NILCLASS_I)
    frozen_f.freeze()
    frozen_n = Node.new(NILCLASS_I, TEST_SYMBOL, frozen_f).freeze()
    clone = frozen_n.clone_df()
    refute_equal(clone, frozen_n)
    assert_predicate(clone, :frozen?)

  end

  # b().

  # test_b_x1().
  # @description
  #   A nil back reference.
  def test_b_x1()
    assert_same(NILCLASS_I, @node1.b())
  end

  # test_b_x2().
  # @description
  #   A Node instance.
  def test_b_x2()

    n = Node.new(@node1, TEST_SYMBOL, NILCLASS_I)
    assert_same(n.b(), @node1)
    assert_raises(FrozenError) {
      @node1.data = TEST_SYMBOL
    }

  end

  # data().

  # test_data_x1().
  # @description
  #   A valid DataType type instance.
  def test_d_x1()

    n = Node.new(NILCLASS_I, TEST_FLOAT, NILCLASS_I)
    assert_same(n.data(), TEST_FLOAT)
    assert_predicate(n.data(), :frozen?)

  end

  # f().

  # test_f_x1().
  # @description
  #   front is nil.
  def test_f_x1()
    n = Node.new(NILCLASS_I, INTEGER_DATA, NILCLASS_I)
    assert_same(NILCLASS_I, n.f())
  end

  # test_f_x2().
  # @description
  #   front refers a Node instance.
  def test_f_x2()

    n = Node.new(NILCLASS_I, INTEGER_DATA, @node1)
    assert_same(n.f(), @node1)
    assert_raises(FrozenError) {
      @node1.data = TEST_SYMBOL
    }

  end

  # data=(dti = nil).

  # test_dass_x1().
  # @description
  #   Any argument excluding a DataType type instance.
  def test_dass_x1()
    assert_raises(DataError) {@lone.data = 'invalid data'}
  end

  # test_dass_x2().
  # @description
  #   Any DataType type instance argument.
  def test_dass_x2()
    @lone.data = TEST_FLOAT
    assert_same(TEST_FLOAT, @lone.data())
  end

  # ==(n = nil).

  # test_attreq_x1().
  # @description
  #   Any argument exlcuding Node arguments.
  def test_attreq_x1()
    refute_equal(@lone, TEST_SYMBOL)
  end

  # test_attreq_x2().
  # @description
  #   A Node attributively equals itself.
  def test_attreq_x2()
    assert_equal(@lone, @lone)
  end

  # teset_attreq_x3().
  # @description
  #   The argument's 'back' and self's 'back' are identical. The argument's
  #   'data' and self's 'data' are identical, and the argument's 'front' and
  #   self's 'front' are identical.
  def test_attreq_x3()
    l_sc = @lone.shallow_clone()
    assert_equal(l_sc, @lone)
  end

  # test_attreq_x4().
  # @description
  #   The argument's 'back' is unidentical.
  def test_attreq_x4()

    unidentical_f = NODE1.shallow_clone()
    n1 = Node.new(NILCLASS_I, TEST_SYMBOL, unidentical_f)
    refute_equal(n1, @base)

  end

  # test_attreq_x5().
  # @description
  #   The argument's 'back' and self's 'back' are identical; the argument's
  # 'data' and self's 'data' are unidentical; and the argument's 'front' and
  # self's 'front' are identical.
  def test_attreq_x5()

    l_clone = @lone.shallow_clone()
    l_clone.data = TEST_FLOAT
    refute_equal(l_clone, @lone)

  end

  # test_attreq_x6().
  # @description
  #   The argument's 'back' and self's 'back' are identical; the argument's
  # 'data' and self's 'data' are identical; and the argument's 'front' and
  # self's 'front' are unidentical.
  def test_attreq_x6()

    unidentical_f = Node.new(NILCLASS_I, TEST_SYMBOL, NILCLASS_I)
    comp_b = Node.new(NILCLASS_I, TEST_SYMBOL, unidentical_f)
    refute_equal(comp_b, @base)

  end

  # data().

  # test_data_value_gets().
  # @description
  #   A data value initialized node gets appropriately.
  def test_data_value_gets()
    value_node = CLASS.new(NILCLASS_I, ONE, NILCLASS_I)
    assert_operator(ONE, 'equal?', value_node.data())
  end

  # test_data_object_gets().
  # @description
  #   A data instance returns a reference.
  def test_data_object_gets()

    data_obj = 3.14
    do_node = CLASS.new(NILCLASS_I, data_obj, NILCLASS_I)
    assert_same(data_obj, do_node.data())

  end

  # ===(n = ni).

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

  # inspect().

  # test_inspect_x1().
  # @description
  #   A base node.
  def test_inspect_x1()

    x3 = @base
    data_text     = "data: #{x3.data()}"
    padding       = (31 - data_text.length()) / 2
    space         = ' ' * padding
    expected      = "| base #{x3.to_s()} |\n| #{space}data: #{x3.data()}" +
        "#{space} |"
    y3            = x3.inspect()
    assert_equal(expected, y3)

  end

  # test_inspect_x2().
  # @description
  #   A common node.
  def test_inspect_x2()

    x4            = @common
    data_text     = "data: #{x4.data()}"
    padding       = (26 - data_text.length()) / 2
    space         = ' ' * padding
    expected      = "| #{x4.to_s()} |\n" +
        "| #{space}data: #{x4.data()}#{space}  |"
    y4            = x4.inspect()
    assert_equal(expected, y4)

  end

  # test_inspect_x3().
  # @description
  #   A lone node.
  def test_inspect_x3()

    data_text = "data: #{@lone.data()}"
    padding   = (31 - data_text.length()) / 2
    space     = ' ' * padding
    y1        = "| base #{@lone.to_s()} |\n| #{space}data: #{@lone.data()
    }#{space} |"
    assert_equal(y1, @lone.inspect())

  end

  # test_inspect_x4().
  # @description
  #   A pioneer node.
  def test_inspect_x4()

    x2            = @pioneer
    y2            = x2.inspect()
    data_text     = "data: #{x2.data()}"
    padding       = (26 - data_text.length()) / 2
    space         = ' ' * padding
    expected      = "| #{x2.to_s()} |\n" +
        "| #{space}data: #{x2.data()}#{space}  |"
    assert_equal(expected, y2)

  end

  # Protected methods.

  # back_ref().

  # test_br_x1().
  # @description
  #   'back_ref()' was protected.
  def test_br_x1()
    assert_raises(NameError) {@lone.back_ref()}
  end

  # front_ref().

  # test_fr_x1().
  # @description
  #   'front_ref' was protected.
  def test_fr_x1()
    assert_raises(NameError) {@lone.front_ref()}
  end

  # Private methods.

  # back().

  # test_back_x1().
  # @description
  #   'back()' is private.
  def test_back_x1()
    assert_raises(NameError) {@lone.back()}
  end

  # front().

  # test_front_x1().
  # @description
  #   'front' is private.
  def test_front_x1()
    assert_raises(NameError) {@lone.front()}
  end

  # back=(n = nil).

  # test_bass_x1().
  # @description
  #   'back=(n = nil)' is private.
  def test_bass_x1()
    assert_raises(NameError) {@lone.back = 'hello'}
  end

  # test_bass_x2().
  # @description
  #   Initializing an invalid back.
  def test_bass_x2()

    assert_raises(NodeError, "The argument is not a Node instance.") {
      Node.new(TEST_SYMBOL, TEST_SYMBOL, NILCLASS_I)
    }

  end

  # front=(n = nil).

  # test_fass_x1().
  # @description
  #   'front=(n = nil)' is private.
  def test_fass_x1()
    assert_raises(NameError) {@lone.front = 'hello'}
  end

  # test_fass_x2().
  # @description
  #   Initializing an invalid front.
  def test_fass_x2()

    assert_raises(NodeError, "The argument is not a Node instance.") {
      Node.new(NILCLASS_I, TEST_SYMBOL, TEST_SYMBOL)
    }

  end

  # teardown().
  # @description
  #   Cleanup.
  def teardown()
  end

end
