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
      # A binary operator contains two children (left and right) nodes.
      class BinaryOperatorNode < Node
        attr_reader :left, :right

        def initialize(left, token, right)
          super(token)

          @name  = 'binary_operator_node'
          @left  = left
          @right = right
        end
      end
    end
  end
end
