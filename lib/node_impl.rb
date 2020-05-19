# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

require_relative "node_impl/version"
require_relative 'helpers/state_helper'
require_relative 'helpers/kind_helper'
require 'data_type'
require 'node_error_library'
require 'diagram_factory_comp'

# Node.
# @class_description
#   A doubly-linked Node data structure library's implementation.
# @attr back [Node]
#   A backward reference.
# @attr data [DataType]
#   Any instance. Refer the Data Library
#   {https://docs.diligentsoftware.org/data#classification Classification}.
# @attr front [Node]
#   A forward reference.
class Node < NodeInt

  include StateHelper
  include KindHelper

  # initialize(b_n = nil, dti = nil, f_n = nil).
  # @description
  #   Initializes Node instances.
  # @param b_n [Node]
  #   The back reference assignment.
  # @param f_n [Node]
  #   The front reference assignment.
  # @param dti [DataType]
  #   A DataType type instance.
  # @return [Node]
  #   An instance.
  def initialize(b_n = nil, dti = nil, f_n = nil)

    self.back  = b_n
    self.data  = dti
    self.front = f_n

  end

  # shallow_clone().
  # @description
  #   Shallowly clones.
  # @return [Node]
  #   A clone. The clone and self are not identical, and share the same
  #   attribute references.
  def shallow_clone()

    n = Node.new(back(), data(), front())
    if (frozen?())
      return n.freeze()
    else
      return n
    end

  end

  # clone_df().
  # @description
  #   Deeply clones.
  # @return [Node]
  #   A deep clone. No Node references are identical. Data references are
  #   identical.
  def clone_df()

    b = back().clone()
    d = data()
    f = front().clone()
    n = Node.new(b, d, f)
    if (frozen?())
      return n.freeze()
    else
      return n
    end

  end

  # b().
  # @description
  #   Gets back.
  # @return [Node, NilClass]
  #   back's reference, frozen.
  def b()
    return back().freeze()
  end

  # data().
  # @description
  #   Gets 'data'.
  # @return [DataType]
  #   data's reference, frozen.
  def data()
    return @data
  end

  # f().
  # @description
  #   Gets front.
  # @return [Node, NilClass]
  #   front's reference, frozen.
  def f()
    return front().freeze()
  end

  # data=(dti = nil).
  # @description
  #   Sets 'data'.
  # @param dti [DataType]
  #   The data setting.
  # @return [DataType]
  #   The argument.
  # @raise [DataError]
  #   In the case the argument is any type other than a DataType type.
  def data=(dti = nil)

    error = DataError.new()
    unless (DataType.instance?(dti))
      raise(error, error.message())
    else
      @data = dti
    end

  end

  # ==(n = nil).
  # @description
  #   Attribute equality operator. Compares the lhs and rhs's attributes.
  # @param n [.]
  #   Any instance.
  # @return [TrueClass, FalseClass]
  #   True in the case n is a Node and its attribute references are identical.
  #   False otherwise.
  def ==(n = nil)

    unless (n.instance_of?(Node))
      return false
    else
      eq = (back().equal?(n.back_ref()) && (data().equal?(n.data())) &&
          (front().equal?(n.front_ref())))
      return eq
    end

  end

  # ===(n = nil).
  # @description
  #   Identity comparison operator.
  # @param n [.]
  #   Any instance.
  # @return [TrueClass, FalseClass]
  #   True in the case the instance and self are the same node.
  def ===(n = nil)
    return equal?(n)
  end

  # inspect().
  # @description
  #   Gets an existing Diagram, or builds one.
  # @return [String]
  #   self's diagram.
  def inspect()

    df_singleton = DiagramFactory.instance()
    diagram = df_singleton.diagram(self)
    return diagram.form()

  end

  protected

  # back_ref().
  # @description
  #   Gets back's reference.
  # @return [Node, NilClass]
  #   The reference.
  def back_ref()
    return back()
  end

  # front_ref().
  # @description
  #   Gets front's reference.
  # @return [Node, NilClass]
  #   front's reference.
  def front_ref()
    return front()
  end

  private

  # back().
  # @description
  #   Gets back.
  # @return [Node]
  #   back's Node reference.
  def back()
    return @back
  end

  # front().
  # @description
  #   Gets front.
  # @return [Node]
  #   front's Node reference.
  def front()
    return @front
  end

  # back=(n = nil).
  # @description
  #   Assigns back the node.
  # @param n [Node]
  #   A Node or NilClass instance becoming the back instance.
  # @raise [NodeError]
  #   In the case the argument is anything other than a Node instance.
  def back=(n = nil)

    error = NodeError.new()
    if (!(n.instance_of?(Node) || n.nil?()))
      raise(error, error.message())
    else
      @back = n
    end

  end

  # front=(n = nil).
  # @description
  #   Assigns front the node.
  # @param n [Node]
  #   A Node or NilClass instance becoming the front Node reference.
  def front=(n = nil)

    error = NodeError.new()
    if (!(n.instance_of?(Node) || n.nil?()))
      raise(error, error.message())
    else
      @front = n
    end

  end

end
