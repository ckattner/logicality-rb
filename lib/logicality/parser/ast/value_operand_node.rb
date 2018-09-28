# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Logicality
  module Parser
    module Ast
      # A value operand node is a node with no children but holds a value instead.
      class ValueOperandNode < Node
        attr_reader :value

        def initialize(token)
          super(token)

          @name  = 'value_operand_node'
          @value = token.value
        end
      end
    end
  end
end
