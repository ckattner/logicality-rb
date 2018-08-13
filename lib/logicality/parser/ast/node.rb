#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Logicality
  module Parser
    module Ast
      class Node

        attr_reader :token, :name

        def initialize(token)
          @token = token
          @name  = ''
        end

        def to_s
          "AstNode: #{self.class.name}::#{token}"
        end

      end
    end
  end
end
