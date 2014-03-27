require_relative '../lib/leaktest'

array = []
leaks = Leaktest.test do
  array << {'a' => :b}
end

puts leaks.inspect
