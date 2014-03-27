require_relative '../../leaktest'

module Leaktest::RSpec
  module Matchers
    class Leak
      def matches?(block)
        @leaks = Leaktest.test(&block)
        @leaks.size > 0
      end

      def failure_message_for_should
        "expected a leak, but none was found"
      end

      def failure_message_for_should_not
        "expected no leak, but the following object classes leaked:\n" + @leaks.map{|cl,ct| "  #{cl}: #{ct}"}.join("\n  ")
      end
    end

    def leak
      Matchers::Leak.new
    end
  end
end
