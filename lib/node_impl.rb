# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the MIT License.

require_relative "node_impl/version"

# Node.
# @abstract
# A doubly-linked Node implementation.
class Node < NodeInt

  include NodeHelper

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

  # copy_constructor().
  # @abstract
  # Copies the left-hand side Node.
  # @return [Node] copy
  # A Node containing the same attribute values, and different object
  # references.
  def copy_constructor()
    return initialize_copy()
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
  # The date object's copy. Self's data and the returned copy refer separate
  # objects.
  def data()
    return @data.clone()
  end

  # back().
  # @abstract
  # Getter. Gets the back Node reference.
  # @return [Node] copy
  # The preceding Node's copy. The attribute values are the same and the
  # object references differ.
  def back()

    if (@back.nil?())
      return @back
    else
      return @back.copy_constructor()
    end

  end

  # front().
  # @abstract
  # Getter. Gets the proceeding Node's reference.
  # @return [Node] copy
  # A Node copy. The copy's references differ and the values are the same.
  def front()

    if (@front.nil?())
      return @front
    else
      return @front.copy_constructor()
    end

  end

  # type().
  # @abstract
  # Gets the Node's data type.
  # @return [Constant] type.
  # The data attribute's constant identifier.
  def type()
    return @data.class()
  end

  # ==(rhs).
  # @abstract
  # Attribute equality operator.
  # @param [Node] rhs
  # A Node object.
  # @return [TrueClass, FalseClass]
  # True in the case the front and back attributes are the same type, and
  # the data attributes are the same type and value.
  def ==(rhs)
    attribute_predicate =
        ((back().class().equal?(rhs.back().class())) &&
            (front().class().equal?(rhs.front().class())) &&
            (type().equal?(rhs.type())) &&
            (data() == rhs.data()))
    return attribute_predicate
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
  # Represents the Node structure.
  # @return [String]
  # The representation.
  def inspect()

    node_structure = STRUCTURE.dup()
    node_structure[:back]  = string_rep(back())
    node_structure[:data] = @data.inspect()
    node_structure[:front] = string_rep(front())
    return "#{to_s()}: #{node_structure.to_s()}"

  end

  private

  # back=(back).
  # @abstract
  # Setter. Assigns the back node.
  # @param [Node, NilClass] back
  # A Node or NilClass object becoming the back Node reference.
  def back=(back)
    @back = back
  end

  # data=(data).
  # @abstract
  # Assigns the data reference.
  # @param [Object] data
  # A data object.
  def data=(data)
    @data = data
  end

  # front=(front).
  # @abstract
  # Assigns the front reference.
  # @param [Node, NilClass] front
  # A Node or NilClass object.
  def front=(front)
    @front = front
  end

  # initialize_copy()
  # @abstract
  # Initializes a self copy.
  # @return [Node] copy
  # The object and attribute object references differ.
  def initialize_copy()

    back_copy  = (Node.new(back(), data(), front())) unless @back.nil?()
    data_copy  = data()
    front_copy = (Node.new(back(), data(), front())) unless @front.nil?()
    copy       = Node.new(back_copy, data_copy, front_copy)
    return copy

  end

end