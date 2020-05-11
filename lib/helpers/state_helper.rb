# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

# StateHelper.
# @module_description
#   State predicates.
module StateHelper

  # back_attached().
  # @description
  #   A back attribute predicate.
  # @return [TrueClass, FalseClass]
  #   True in the case back refers a Node instance. False otherwise.
  def back_attached()
    return !back().nil?()
  end

  # front_attached().
  # @description
  #   A front attribute predicate.
  # @return [TrueClass, FalseClass]
  #   True in the case front refers a Node instance. False otherwise.
  def front_attached()
    return !front().nil?()
  end

  # no_attachments().
  # @description
  #   A back and front attribute predicate.
  # @return [TrueClass, FalseClass]
  #   True in the case back and front refer nil. False otherwise.
  def no_attachments()
    return(!back_attached() && !front_attached())
  end

  # empty().
  # @description
  #   A data attribute predicate.
  # @return [TrueClass, FalseClass]
  #   True in the case data refers nil. False otherwise.
  def empty()
    return data().nil?()
  end

  # both_attached().
  # @description
  #   Predicate. Verifies 'back' and 'front' are attachments.
  # @return [TrueClass, FalseClass]
  #   True in the case 'back' and 'front' refer Nodes. False otherwise.
  def both_attached()
    return (back_attached() && front_attached())
  end

end