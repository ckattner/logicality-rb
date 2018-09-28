# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Logicality
  module Parser
    # Parser that takes in a lexer and can take its parsed grammar and turn it into an
    # abstract syntax tree.
    class SimpleParser
      attr_reader :lexer

      def initialize(lexer)
        @lexer = lexer

        @current_token = lexer.next_token

        raise ArgumentError, 'Lexer must contain at least one token' if @current_token.nil?
      end

      def parse
        expr
      end

      private

      BINARY_TYPES = [
        Lexer::Token::Type::AND_OP,
        Lexer::Token::Type::OR_OP
      ].freeze

      attr_reader :current_token

      def error
        raise ArgumentError, 'Invalid parser syntax'
      end

      def eat(token_type)
        if current_token.type == token_type
          @current_token = lexer.next_token
        else
          error
        end

        nil
      end

      def factor
        token = current_token

        if current_token.type == Lexer::Token::Type::VALUE
          eat(Lexer::Token::Type::VALUE)

          Ast::ValueOperandNode.new(token)
        elsif current_token.type == Lexer::Token::Type::LEFT_PAREN
          eat(Lexer::Token::Type::LEFT_PAREN)
          node = expr
          eat(Lexer::Token::Type::RIGHT_PAREN)

          node
        elsif current_token.type == Lexer::Token::Type::NOT_OP
          eat(Lexer::Token::Type::NOT_OP)
          node = factor

          Ast::UnaryOperatorNode.new(node, token)
        else
          raise ArgumentError, "Factor cannot determine what to do with: #{token}"
        end
      end

      def expr
        node = factor

        loop do
          break unless current_token && BINARY_TYPES.include?(current_token.type)

          token = current_token

          if token.type == Lexer::Token::Type::AND_OP
            eat(Lexer::Token::Type::AND_OP)
          elsif token.type == Lexer::Token::Type::OR_OP
            eat(Lexer::Token::Type::OR_OP)
          end

          node = Ast::BinaryOperatorNode.new(node, token, factor)
        end

        node
      end
    end
  end
end
