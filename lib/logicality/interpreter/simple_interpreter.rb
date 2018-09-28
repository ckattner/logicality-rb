# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Logicality
  module Interpreter
    # This class implements NodeVisitor and gives each type of node the proper type of visitor
    # implementation.
    class SimpleInterpreter < NodeVisitor
      attr_reader :resolver

      def initialize(resolver)
        raise ArgumentError, 'Resolver is required' unless resolver

        @resolver = resolver
      end

      def error(node)
        raise ArgumentError, "Visitor cant process node token type: #{node.token.type}"
      end

      def visit_binary_operator_node(node)
        if node.token.type == Lexer::Token::Type::AND_OP
          visit(node.left) && visit(node.right)
        elsif node.token.type == Lexer::Token::Type::OR_OP
          visit(node.left) || visit(node.right)
        else
          error(node)
        end
      end

      def visit_unary_operator_node(node)
        if node.token.type == Lexer::Token::Type::NOT_OP
          !visit(node.child)
        else
          error(node)
        end
      end

      def visit_value_operand_node(node)
        if node.value == 'true'
          true
        elsif node.value == 'false' || node.value == 'null'
          false
        else
          resolve_value(node.value)
        end
      end

      private

      def resolve_value(value)
        raise ArgumentError, "No resolver function: #{value}" if resolver.nil?

        !!resolver.call(value)
      end
    end
  end
end
