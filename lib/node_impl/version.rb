# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released 
# under the MIT License.

require 'node_int'
require_relative 'node_helper'

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
  VERSION = '2.0.0'.freeze()
end