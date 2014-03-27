# Run with rspec

require_relative '../lib/leaktest/rspec'

describe 'my app' do
  it 'should not leak' do
    # will really leak
    array = []
    expect{array << {'a' => :b}}.to_not leak
    # Leaked the string 'a' and the hash containing it
  end

  it 'should also not leak' do
    expect{array = []; array << Time.new}.to_not leak
  end
end
