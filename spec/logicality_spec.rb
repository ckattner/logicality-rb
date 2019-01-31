# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require './lib/logicality'

def run(tests)
  tests.each do |x|
    input = x[1] ? x[1].map { |k, v| [k.to_s, v] }.to_h : nil

    result = Logicality.evaluate(x[0], input)

    expect(result).to eq(x[2]), "Failed: #{x[0]} (input: #{input}): expected #{x[2]} got: #{result}"
  end

  nil
end

describe Logicality do
  context 'when evaluating' do
    it 'should evaluate boolean-only expressions' do
      tests = [
        ['true',           nil, true],
        ['false',          nil, false],
        ['true && false',  nil, false],
        ['true && true',   nil, true]
      ]

      run(tests)
    end

    it 'should evaluate and expressions' do
      tests = [
        ['a && b', nil,                    false],
        ['a && b', {},                     false],
        ['a && b', { a: true },            false],
        ['a && b', { a: true, b: false },  false],
        ['a && b', { a: false, b: false }, false],
        ['a && b', { a: true, b: true },   true]
      ]

      run(tests)
    end

    it 'should evaluate and-or expressions' do
      tests = [
        ['a && b || c',    { a: false, b: false, c: true },  true],
        ['(a && b) || c',  { a: false, b: false, c: true },  true],
        ['a || b && c',    { a: false, b: false, c: true },  false],
        ['a || (b && c)',  { a: false, b: false, c: true },  false],
        ['(a || b) && c',  { a: false, b: false, c: true },  false]
      ]

      run(tests)
    end

    it 'should evaluate not expressions' do
      tests = [
        ['!a',         { a: false },            true],
        ['!a && !b',   { a: false, b: false },  true],
        ['!a && b',    { a: false, b: false },  false],
        ['a && !b',    { a: false, b: false },  false],
        ['!(a && b)',  { a: false, b: false },  true]
      ]

      run(tests)
    end

    it 'should treat question marks as a valid part of a value token' do
      tests = [
        ['a?',       { 'a?': true },             true],
        ['!a?',      { 'a?': true },             false],
        ['a? && b?', { 'a?': true, 'b?': true }, true],
        ['a && b?',  { a: true, 'b?': true },    true]
      ]

      run(tests)
    end
  end
end
