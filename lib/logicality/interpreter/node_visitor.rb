#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Logicality
  module Interpreter
    class NodeVisitor

      def visit(node)
        return nil unless node

        visitor_name = method_name(node)

        if respond_to?(visitor_name)
          send(visitor_name, node)
        else
          generic_visit(node)
        end
      end

      private

      def generic_visit(node)
        raise ArgumentError, "No visitor method: #{method_name(node)}"
      end

      def method_name(node)
        "visit_#{node.name}"
      end

    end
  end
end
