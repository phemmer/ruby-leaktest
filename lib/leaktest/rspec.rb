require_relative 'rspec/matchers'

RSpec.configure {|c| c.include Leaktest::RSpec::Matchers}
