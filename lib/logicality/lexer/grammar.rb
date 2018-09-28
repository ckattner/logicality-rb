# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Logicality
  module Lexer
    # Define the main regular expression matchers used by the lexer.
    module Grammar
      VALUE       = /([a-zA-Z0-9_$@?\.]+)/
      AND_OP      = /(&&)/
      OR_OP       = /(\|\|)/
      NOT_OP      = /(\!)/
      LEFT_PAREN  = /(\()/
      RIGHT_PAREN = /(\))/
    end
  end
end
