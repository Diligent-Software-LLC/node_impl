# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

require_relative "node_impl/version"
require_relative 'helpers/inspect_helper'
require_relative 'helpers/state_helper'
require 'data_library'
require 'node_error_library'
require 'node_adapter'

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
  include StateHelper

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
  #   self's shallow clone. In the case self contains Node references, its
  #   clone's Node references differ. self's and its clone's data references
  #   are identical.
  def shallow_clone()
    n = Node.new(back().clone(), data().clone(), front().clone())
    return n
  end

  # clone_df().
  # @description
  #   Clones deeply, and freezes the deep clones.
  # @return [Node]
  #   self's clone. The attribute references are self's attribute references.
  #   The instances are frozen.
  def clone_df()
    n = Node.new(b(), d(), f())
    return n
  end

  # substitute(dti = nil).
  # @description
  #   Substitutes data.
  # @param dti [DataType]
  #   The substitution data.
  # @return [DataType]
  #   The argument.
  # @raise [DataError]
  #   In the case the argument is not a DataType type instance.
  def substitute(dti = nil)
    self.data = dti
    return dti
  end

  # b().
  # @description
  #   Gets back.
  # @return [Node, NilClass]
  #   back's reference, frozen.
  def b()
    return back().freeze()
  end

  # d().
  # @description
  #   Gets data.
  # @return [DataType]
  #   data's reference, frozen.
  def d()
    return data().freeze()
  end

  # f().
  # @description
  #   Gets front.
  # @return [Node, NilClass]
  #   front's reference, frozen.
  def f()
    return front().freeze()
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
      eq = (back().eql?(n.back_ref()) && (data() == n.data_ref()) &&
          front().eql?(n.front_ref()))
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
    when no_attachments()
      lines = lone_insp()
    when pioneer()
      lines = pioneer_insp()
    when base()
      lines = base_insp()
    else
      lines = common_insp()
    end
    upper   = lines[:upper]
    lower   = lines[:lower]
    diagram = upper + "\n" + lower
    return diagram

  end

  # attach_back(n = nil).
  # @description
  #   Attaches back a Node.
  # @param n [Node]
  #   An attachment Node.
  # @return [NilClass]
  #   nil.
  # @raise [ArgumentError]
  #   In the case the argument is any type other than Node.
  def attach_back(n = nil)

    if (!n.instance_of?(Node))
      raise(ArgumentError, "#{n} is not a Node instance.")
    else
      self.back = n
    end

  end

  # attach_front(n = nil).
  # @description
  #   Attaches front the argument Node.
  # @param n [Node]
  #   The attachment.
  # @return [NilClass]
  #   nil.
  # @raise [ArgumentError]
  #   In the case the argument is any type other than Node.
  def attach_front(n = nil)

    if (!n.instance_of?(Node))
      raise(ArgumentError, "#{n} is not a Node instance.")
    else
      self.front = n
    end

  end

  # detach_back().
  # @description
  #   Sets back nil.
  # @return [NilClass]
  #   nil.
  def detach_back()
    self.back = nil
  end

  # detach_front().
  # @description
  #   Sets front nil.
  # @return [NilClass]
  #   nil.
  def detach_front()
    self.front = nil
  end

  # adapt().
  # @description
  #   Instantiates an adapter.
  # @return [NodeAdapter]
  #   An adapter instance.
  def adapt()
    return NodeAdapter.new(self)
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

  # data_ref().
  # @description
  #   Gets data's reference.
  # @return [DataType]
  #   data's reference.
  def data_ref()
    return data()
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

  # data().
  # @description
  #   Gets data.
  # @return [DataType]
  #   The data reference.
  def data()
    return @data
  end

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
