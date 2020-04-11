# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

# InspectHelper.
# @module_description
#   Factored inspect code blocks.
module InspectHelper

  # Constants.
  ARROWLESS_LENGTH = 30
  ONE_ARROW_LENGTH = 33
  TWO_ARROW_LENGTH = 36
  # Pipes and padding length.
  P_AND_P_LENGTH   = 4
  MAX_BODY_LENGTH  = 26
  MIN_LOWER_LENGTH = 9
  ARROW_PADDING    = ' ' * 3

  # Illustrative Symbols.
  BACK_ARROW  = '<--'.freeze()
  FRONT_ARROW = '-->'.freeze()
  PIPE        = '|'.freeze()

  # upper_row().
  # @description
  #   Constructs the upper row diagram less any arrows.
  # @return [String]
  #   The upper row.
  def upper_row()
    return (PIPE + " #{to_s()} " + PIPE)
  end

  # lower_row().
  # @description
  #   Constructs the lower row diagram less any arrows. Centers the data text.
  # @return [String]
  #   The lower row.
  def lower_row

    lower_text   = "data: #{data()}"
    lower_text_l = lower_text.length()
    padding      = (MAX_BODY_LENGTH - lower_text_l) / 2
    p_space      = ' ' * padding
    l_body       = p_space + lower_text + p_space
    l_body       += ' ' if (P_AND_P_LENGTH + l_body.length() < ARROWLESS_LENGTH)
    row          = "#{PIPE} #{l_body} #{PIPE}"
    return row

  end

  # only_data_insp().
  # @description
  #   The back and front attributes are nil.
  # @return [Hash]
  #   A hash containing 'upper' and 'lower' hashes. The 'upper' and 'lower'
  #   hashes' values are the upper and lower row strings.
  def only_data_insp()

    diagram_rows         = {}
    diagram_rows[:upper] = upper_row()
    diagram_rows[:lower] = lower_row()
    return diagram_rows

  end

  # nil_back_insp().
  # @description
  #   The back attribute is nil.
  # @return [Hash]
  #   A hash containing 'upper' and 'lower' hashes. The 'upper' and 'lower'
  #   hashes' values are the upper and lower row strings.
  def nil_back_insp()

    diagram_rows         = {}
    diagram_rows[:upper] = upper_row() + FRONT_ARROW
    diagram_rows[:lower] = lower_row() + ARROW_PADDING
    return diagram_rows

  end

  # nil_front_insp().
  # @description
  #   The front attribute is nil.
  # @return [Hash]
  #   A hash containing 'upper' and 'lower' hashes. The 'upper' and 'lower'
  #   hashes' values are the upper and lower row strings.
  def nil_front_insp()

    diagram_rows         = {}
    diagram_rows[:upper] = ARROW_PADDING + upper_row()
    diagram_rows[:lower] = BACK_ARROW + lower_row()
    return diagram_rows

  end

  # doubly_linked_insp().
  # @description
  #   The front and back attributes refer nodes.
  # @return [Hash]
  #   A hash containing 'upper' and 'lower' hashes. The 'upper' and 'lower'
  #   hashes' values are the upper and lower row strings.
  def doubly_linked_insp()

    diagram_rows         = {}
    diagram_rows[:upper] = ARROW_PADDING + upper_row() + FRONT_ARROW
    diagram_rows[:lower] = BACK_ARROW + lower_row() + ARROW_PADDING
    return diagram_rows

  end

end
