# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

require_relative "node_impl/version"
require_relative 'node_impl/inspect_helper'
require 'data_library'
require 'node_error_library'

# Node.
# @class_description
#   A doubly-linked Node data structure implementation.
# @attr back [Node]
#   A back node.
# @attr data [DataType]
#   Any DataType instance. Refer the Data Library Homepage's
#   {https://docs.diligentsoftware.org/data#data-types Data Types} section.
# @attr front [Node]
#   A front node.
class Node < NodeInt

  include InspectHelper

  # initialize(b_n = nil, dti = nil, f_n = nil).
  # @description
  #   Initializes Node instances.
  # @param b_n [Node]
  #   The back attribute assignment.
  # @param f_n [Node]
  #   The front attribute assignment.
  # @param dti [DataType]
  #   A DataType instance.
  # @return [Node]
  #   A Node instance.
  def initialize(b_n = nil, dti = nil, f_n = nil)

    self.back  = b_n
    self.data  = dti
    self.front = f_n

  end

  # clone_df().
  # @description
  #   Clones deeply, and freezes the deep clones.
  # @return [Node]
  #   self's clone. The attribute references are self's attribute references.
  #   The instances are frozen.
  def clone_df()
    n = Node.new(back(), data(), front())
    return n
  end

  # substitute(rhs = nil).
  # @description
  #   Assigns self's attribute references rhs's attribute references.
  # @param rhs [Node]
  #   The substitution node.
  # @return [NilClass]
  #   nil.
  # @raise [NodeError]
  #   In the case the argument is not a Node instance.
  def substitute(rhs = nil)

    self.back  = rhs.back()
    self.data  = rhs.data()
    self.front = rhs.front()
    return nil

  end

  # data().
  # @description
  #   Gets the data attribute reference.
  # @return [DataType]
  #   The data instance, frozen.
  def data()
    return @data.freeze()
  end

  # back().
  # @description
  #   Gets the back Node reference.
  # @return [Node]
  #   The back Node reference, frozen.
  def back()
    return @back.freeze()
  end

  # front().
  # @description
  #   Gets the front Node reference.
  # @return [Node]
  #   The front Node reference, frozen.
  def front()
    return @front.freeze()
  end

  # type().
  # @description
  #   Gets the data's type.
  # @return [Class]
  #   The data instance's constant identifier.
  def type()
    return @data.class()
  end

  # ==(n = nil).
  # @description
  #   Attribute equality operator. Compares the lhs and rhs's attributes.
  # @param n [.]
  #   Any instance.
  # @return [TrueClass, FalseClass]
  #   True in the case the back nodes are attributively equal, the data objects
  #   are attributively equal, and the front nodes are attributively equal.
  #   False otherwise.
  def ==(n = nil)

    if (!n.instance_of?(Node))
      return false
    else
      eq = ((back() == n.back()) && data() == n.data() && front() == n.front())
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
  #   Represents the Node structure diagrammatically. The diagram represents the
  #   Node in an upper row and a lower row. The upper row contains the Node's
  #   'to_s()' representation between pipes. In the case the Node's front
  #   attribute refers a Node, there is a right arrow leading the right
  #   pipe. The lower row is the data instance's evaluation between pipes and
  #   following a 'data: ' label. In the case the Node's back attribute refers a
  #   Node, preceding the left pipe is a left arrow. The InspectHelper
  #   method calls return a hash containing :lower and :upper row hashes. The
  #   row hashes' values are the corresponding row Strings. The inspect method
  #   inserts a newline character between the row Strings, and returns their
  #   concatenation.
  # @return [String]
  #   The representation diagram.
  def inspect()

    case
    when back().nil?() && front().nil?()
      lines = only_data_insp()
    when !back().nil?() && front().nil?()
      lines = nil_front_insp()
    when back().nil?() && !front().nil?()
      lines = nil_back_insp()
    else
      lines = doubly_linked_insp()
    end
    upper   = lines[:upper]
    lower   = lines[:lower]
    diagram = upper + "\n" + lower
    return diagram

  end

  private

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

  # data=(dti = nil).
  # @description
  #   Assigns data the argument.
  # @param dti [DataType]
  #   A data type instance.
  # @raise [DataError]
  #   In the case the argument is anything other than a DataType instance.
  def data=(dti = nil)

    error = DataError.new()
    if (!DataType.instance?(dti))
      raise(error, error.message())
    else
      @data = dti
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
