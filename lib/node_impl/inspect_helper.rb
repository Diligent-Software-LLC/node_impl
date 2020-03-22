# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released under
# the MIT License.

# InspectHelper.
# @abstract
# Factored inspect code blocks.
module InspectHelper

  # only_data_insp().
  # @abstract
  # The back and front attributes are nil.
  # @return [Hash] diagram_h
  # Contains the upper and lower hashes.
  def only_data_insp()

    diagram_h         = {lower: "", upper: ""}
    diagram_h[:upper] = "|#{to_s()}|"
    diagram_h[:lower] = "|data: #{data()}|"
    return diagram_h

  end

  # nil_back_insp().
  # @abstract
  # The back attribute is nil.
  # @return [Hash] diagram_h
  # Contains the upper and lower hashes.
  def nil_back_insp()

    diagram_h         = {lower: "", upper: ""}
    diagram_h[:upper] = "|#{to_s()}|-->"
    diagram_h[:lower] = "|data: #{data()}|"
    return diagram_h

  end

  # nil_front_insp().
  # @abstract
  # The front attribute is nil.
  # @return [Hash] diagram_h
  # Contains the upper and lower hashes.
  def nil_front_insp()

    diagram_h         = {lower: "", upper: ""}
    diagram_h[:upper] = "|#{to_s()}|"
    diagram_h[:lower] = "<--|data: #{data()}|"
    return diagram_h

  end

  # doubly_linked_insp().
  # @abstract
  # The front and back attributes refer nodes.
  # @return [Hash] diagram_h
  # Contains the upper and lower hashes.
  def doubly_linked_insp()

    diagram_h         = {lower: "", upper: ""}
    diagram_h[:upper] = "|#{to_s()}|-->"
    diagram_h[:lower] = "<--|data: #{data()}|"
    return diagram_h

  end

end