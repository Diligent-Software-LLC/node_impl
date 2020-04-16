# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

require 'node_int'

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
  VERSION = '3.1.0'.freeze()
end