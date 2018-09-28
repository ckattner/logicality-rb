# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Logicality
  module Lexer
    # Class that defines the main structure of a Token.  A token is a parsed set of
    # characters.
    class Token
      module Type
        VALUE       = :value
        AND_OP      = :and_op
        OR_OP       = :or_op
        NOT_OP      = :not_op
        LEFT_PAREN  = :left_paren
        RIGHT_PAREN = :right_paren
      end

      attr_reader :type, :value

      def initialize(type, value)
        raise ArgumentError, 'type is required'   unless type   && type.to_s.length.positive?
        raise ArgumentError, 'value is required'  unless value  && value.to_s.length.positive?

        @type   = Type.const_get(type.to_s.upcase.to_sym)
        @value  = value.to_s
      end

      def to_s
        "#{type}::#{value}"
      end
    end
  end
end
