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
      # A unary operator node has just one child node.
      class UnaryOperatorNode < Node
        attr_reader :child

        def initialize(child, token)
          super(token)

          @name   = 'unary_operator_node'
          @child  = child
        end
      end
    end
  end
end
