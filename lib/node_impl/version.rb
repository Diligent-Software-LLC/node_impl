# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

require 'node_int'

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
  VERSION = '4.0.0'.freeze()
end