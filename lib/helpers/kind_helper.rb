# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

# KindHelper.
# @module_description
#   Kind predicates and getters.
module KindHelper

  # kind().
  # @description
  #   Discerns the kind. The kind is either 'base', 'common', 'lone', or
  #   'pioneer'.
  # @return [String]
  #   A kind String.
  def kind()
    case
    when lone()
      return 'lone'.freeze()
    when common()
      return 'common'.freeze()
    when base()
      return 'base'.freeze()
    when pioneer()
      return 'pioneer'.freeze()
    end
  end

  # lone().
  # @description
  #   Predicate. Verifies the kind is lone. A 'lone' Node is a Node bearing
  #   no attachments.
  # @return [TrueClass, FalseClass]
  #   True in the case self's 'back' reference and self's 'front' reference
  #   are nil. False otherwise.
  def lone()
    return no_attachments()
  end

  # common().
  # @description
  #   Predicate. Verifies the kind is common. A 'common' Node is a fully
  #   attached Node.
  # @return [TrueClass, FalseClass]
  #   True in the case both 'back' and 'front' refer Nodes.
  def common()
    return (back_attached() && front_attached())
  end

  # base().
  # @description
  #   Predicate. Verifies the kind is 'base'. A 'base' Node is a Node bearing
  #   no backward attachment and a forward attachment.
  # @return [TrueClass, FalseClass]
  #   True in the case 'back' is nil and 'front' refers a Node. False otherwise.
  def base()
    return (!back_attached() && front_attached())
  end

  # pioneer().
  # @description
  #   Predicate. Verifies self's kind is 'pioneer'. A 'pioneer' Node is a
  #   Node bearing a 'back' attachment and no 'front' attachment.
  # @return [TrueClass, FalseClass]
  #   True in the case self's 'back' reference is a Node and self's 'front'
  #   reference is nil. False otherwise.
  def pioneer()
    return (back_attached() && !front_attached())
  end

end