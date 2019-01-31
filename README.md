*Note: This is a ruby implementation of [Logicality](https://github.com/bluemarblepayroll/logicality).*

# Logicality

[![Build Status](https://travis-ci.org/bluemarblepayroll/logicality-rb.svg?branch=master)](https://travis-ci.org/bluemarblepayroll/logicality-rb)

A common problem that many frameworks have is the ability to give developers an expressive
intermediary scripting language or DSL. Logicality helps solve this problem by providing a simple
boolean expression evaluator.  That way, your developers can create simple scripts for dynamically
resolving boolean values such as:

* a
* b
* a && b
* a || b
* a && b || c
* (a && b) || (c && d)
* (a && b) || (c && (d || e && f))

## Credit

Deep inspiration was taken from [this set of articles](https://ruslanspivak.com/lsbasi-part7/).
Here, the author gives details around the theory and practical implementation of creating a basic
language processor and compiler.

## Installation

To install through Rubygems:

````
gem install install logicality
````

You can also add this to your Gemfile:

````
bundle add logicality
````

## Examples

### A simple object-based example.

Consider a case where some content should be displayed if it is marked as visible or if the user is an administrator. You can express this as:

````
visible || admin
````

Now you can bind and evaluate this expression against passed in objects:

````
record = { 'visible' => false, 'admin' => true }
visible = Logicality.evaluate('visible || admin', record) # resolves to true.
````

### Plugging in a Custom Resolver

Notice that the above example uses the default value resolver, which either wants an object that has values as attributes, or an object with a brackets method (i.e. Hash).  In the brackets method approach, keys will be accessed using strings (as opposed to symbols.).  If we wanted to use a custom resolver, for example to use symbols as keys, we could do this:

````
resolver = lambda do |value, input|
  symbolized_hash = (input || {}).map { |k,v| [ k.to_s.to_sym, v] }.to_h
  !!symbolized_hash[value]
end

record = { visible: false, admin: true }
visible = Logicality.evaluate('visible || admin', record, resolver) # resolves to true.
````

## Contributing

### Development Environment Configuration

Basic steps to take to get this repository compiling:

1. Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/) (check logicality.gemspec for versions supported)
2. Install bundler (gem install bundler)
3. Clone the repository (git clone git@github.com:bluemarblepayroll/logicality-rb.git)
4. Navigate to the root folder (cd logicality)
5. Install dependencies (bundle)

### Running Tests

To execute the test suite run:

````
bundle exec rspec spec --format documentation
````

Alternatively, you can have Guard watch for changes:

````
bundle exec guard
````

Also, do not forget to run Rubocop:

````
bundle exec rubocop
````

### Publishing

Note: ensure you have proper authorization before trying to publish new versions.

After code changes have successfully gone through the Pull Request review process then the following steps should be followed for publishing new versions:

1. Merge Pull Request into master
2. Update ```lib/logicality/version.rb``` using [semantic versioning](https://semver.org/)
3. Install dependencies: ```bundle```
4. Update ```CHANGELOG.md``` with release notes
5. Commit & push master to remote and ensure CI builds master successfully
6. Build the project locally: `gem build logicality`
7. Publish package to RubyGems: `gem push logicality-X.gem` where X is the version to push
8. Tag master with new version: `git tag <version>`
9. Push tags remotely: `git push origin --tags`

## License

This project is MIT Licensed.
