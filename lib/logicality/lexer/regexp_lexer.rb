#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Logicality
  module Lexer
    class RegexpLexer
      include Grammar

      class << self

        def invalid_pattern
          "#{pattern}|(\\s*)"
        end

        def invalid_regexp
          Regexp.new(invalid_pattern)
        end

        def pattern
          Grammar.constants.map { |c| Grammar.const_get(c).source }
                           .join('|')
        end

        def regexp
          Regexp.new(pattern)
        end

      end

      attr_reader :expression

      def initialize(expression)
        raise ArgumentError, 'Expression is required' unless expression && expression.to_s.length > 0

        @expression = expression.to_s

        if invalid_matches.length > 0
          raise ArgumentError, "Invalid syntax: #{invalid_matches}"
        end

        reset
      end

      def next_token
        return nil if index > matches.length - 1

        increment

        scan_array = matches[index]

        return nil unless scan_array

        tokens = scan_array.map.with_index do |value, index|
          const = Grammar.constants[index]
          value ? Token.new(const, value) : nil
        end.compact

        if tokens.length > 1
          raise ArgumentError, "Too many tokens found for: #{scan_array}"
        elsif tokens.length == 0
          raise ArgumentError, "Cannot tokenize: #{scan_array}"
        end

        tokens.first
      end

      def reset
        @index = -1

        self
      end

      private

      attr_reader :index

      def increment
        @index += 1

        nil
      end

      def invalid_matches
        @invalid_matches ||= expression.gsub(self.class.invalid_regexp, '')
      end

      def matches
        @matches ||= expression.scan(self.class.regexp)
      end

    end
  end
end
