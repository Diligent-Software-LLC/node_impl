# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the MIT License.

require_relative "node_impl/version"
require_relative 'node_impl/inspect_helper'

# Node.
# @abstract
# A doubly-linked Node implementation.
class Node < NodeInt

  include NodeHelper
  include InspectHelper

  # initialize(back = nil, data = nil, front = nil).
  # @abstract
  # The constructor. The default object's attributes are all nil.
  # @param [Node, NilClass] back
  # The preceding Node.
  # @param [Node, NilClass] front
  # The proceeding Node.
  # @param [Object] data
  # Any data object.
  # @return [Node]
  # A Node instance.
  def initialize(back = nil, data = nil, front = nil)

    self.back  = back
    self.data  = data
    self.front = front

  end

  # clone().
  # @abstract
  # Copies self. Clones back, data, and front. Builds a new node, arguing the
  # corresponding clones.
  # @return [Node] clone
  # self's clone.
  def clone()

    clone       = Node.new()
    b           = back().clone()
    d           = data().clone()
    f           = front().clone()
    clone.back  = b
    clone.data  = d
    clone.front = f
    return clone

  end

  # substitute(rhs).
  # @abstract
  # Substitute the caller's attribute references.
  # @param [Node] rhs
  # A Node substituting self's attributes.
  # @return [NilClass] nil
  def substitute(rhs)

    self.back  = rhs.back()
    self.data  = rhs.data()
    self.front = rhs.front()
    return nil

  end

  # data().
  # @abstract
  # Getter. Gets the data attribute reference.
  # @return [Object]
  # Either a Numeric, FalseClass, Symbol, TrueClass, String, Time, or
  # NilClass object.
  def data()
    return @data
  end

  # back().
  # @abstract
  # Getter. Gets the back Node reference.
  # @return [Node] @back
  # The back Node reference.
  def back()
    return @back
  end

  # front().
  # @abstract
  # Getter. Gets the proceeding Node's reference.
  # @return [Node] @front
  # The front Node reference.
  def front()
    return @front
  end

  # type().
  # @abstract
  # Gets the Node's data type.
  # @return [Constant] type.
  # The data attribute's constant identifier.
  def type()
    return @data.class()
  end

  # back=(node = nil).
  # @abstract
  # Setter. Assigns back the node.
  # @param [Node, NilClass] back
  # A Node or NilClass object becoming the back Node reference.
  def back=(node = nil)

    if (!(node.instance_of?(Node) || node.nil?()))
      raise(ArgumentError, "#{node} is not a Node instance.")
    end
    @back = node

  end

  # data=(data = nil).
  # @abstract
  # Assigns data the data object. In the case the data object is invalid,
  # raises an ArgumentError.
  # @param [Object] data
  # A data object.
  def data=(data = nil)

    if (!(data.kind_of?(Numeric) || data.instance_of?(FalseClass) ||
        data.instance_of?(Symbol) || data.instance_of?(TrueClass) ||
        data.instance_of?(String) || data.instance_of?(Time) ||
        data.instance_of?(NilClass)))
      raise(ArgumentError, "#{data} is not an instance of Numeric,
FalseClass, Symbol, TrueClass, String, Time, or NilClass.")
    end
    @data = data

  end

  # front=(node = nil).
  # @abstract
  # Setter. Assigns front the node.
  # @param [Node, NilClass] node
  # A Node or NilClass object becoming the front Node reference.
  def front=(node = nil)

    if (!(node.instance_of?(Node) || node.nil?()))
      raise(ArgumentError, "#{node} is not a Node instance.")
    end
    @front = node

  end

  # ==(node = nil).
  # @abstract
  # Attribute equality operator. Compares the lhs and rhs's attributes.
  # @param [Object] node
  # Any object.
  # @return [TrueClass, FalseClass] eq
  # True in the case the back nodes are attributively equal, the data objects
  # are attributively equal, and the front nodes are attributively equal.
  # False otherwise.
  def ==(node = nil)

    if (!node.instance_of?(Node))
      return false
    else

      eq = ((back() == node.back()) && data() == node.data() &&
          front() == node.front())
      return eq

    end

  end

  # ===(rhs).
  # @abstract
  # Case equality operator.
  # @param [Node] rhs
  # A Node object.
  # @return [TrueClass, FalseClass]
  # True in the case the object's references are the same.
  def ===(rhs)
    return equal?(rhs)
  end

  # inspect().
  # @abstract
  # Represents the Node structure diagrammatically. The diagram represents the
  # Node in two rows. An upper row and a lower row. The upper row is a String
  # printing the Node's string representation between pipes. In the case the
  # Node's front attribute refers a Node, the upper row also includes a forward
  # arrow. The lower row is a String printing the data between pipes. In the
  # case the Node's back attribute refers a Node, the lower row includes a
  # backwards arrow. In the case the Node refers a back Node and a front Node,
  # the diagram prints a forward and backward arrow. The :upper and :lower
  # hashes store the rows, and the diagram_h variable stores the :upper and
  # :lower hashes. Each node inspect has a corresponding inspect helper.
  # @return [String] diagram
  # The representation diagram.
  def inspect()

    case
    when back().nil?() && front().nil?()

      lines   = only_data_insp()
      upper   = lines[:upper]
      lower   = lines[:lower]
      diagram = upper + "\n" + lower

    when !back().nil?() && front().nil?()

      lines   = nil_front_insp()
      upper   = lines[:upper]
      lower   = lines[:lower]
      diagram = upper + "\n" + lower

    when back().nil?() && !front().nil?()

      lines   = nil_back_insp()
      upper   = lines[:upper]
      lower   = lines[:lower]
      diagram = upper + "\n" + lower

    else

      lines   = doubly_linked_insp()
      upper   = lines[:upper]
      lower   = lines[:lower]
      diagram = upper + "\n" + lower

    end
    return diagram

  end

end