This is a simple gem to check for leaking objects.
It takes a block and executes it multiple times. The first run is not tracked so that it may initialize any static variables. Then it runs again and any new objects are considered leaks.

It includes a rspec matcher that can be used in rspec tests.

# Synopsis

    require 'leaktest'

    array = []
    leaks = Leaktest.test do
      array << {'a' => :b}
    end

    puts leaks.inspect

A working example may be found in the `examples` directory:

    $ ruby examples/leaktest.rb 
    {"String"=>1, "Hash"=>1}


## RSpec

    require 'leaktest/rspec'

    describe 'my app' do
      it 'should not leak' do
        array = []
        expect{array << {'a' => :b}}.to_not leak
      end
    end


A working example can be found in the `examples` directory:

    $ rspec examples/spec.rb

    F.

    Failures:

      1) my app should not leak
         Failure/Error: expect{array << {'a' => :b}}.to_not leak
           expected no leak, but the following object classes leaked:
             String: 1
               Hash: 1
         # ./examples/spec.rb:9:in `block (2 levels) in <top (required)>'

    Finished in 0.08768 seconds
    2 examples, 1 failure

    Failed examples:

    rspec ./examples/spec.rb:6 # my app should not leak
