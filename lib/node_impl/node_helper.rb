# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released under
# the MIT License.

# NodeHelper.
# @abstract
# A Node helper module.
module NodeHelper

  # string_rep().
  # @abstract
  # Takes a Node's back or front attribute and calls an appropriate string
  # conversion method.
  # @param [Node] node
  # The back or front attribute nodes.
  # @return [String] s
  # A string representation.
  def string_rep(node)

    if (node.nil?())
      s = node.inspect()
    else
      s = node.to_s()
    end
    return s

  end

end
