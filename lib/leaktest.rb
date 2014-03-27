module Leaktest
  def self.test(&block)
    object_counts = [{}, {}]

    GC.disable
    2.times do |i|
      block.call
      GC.enable
      GC.start
      GC.disable
      ObjectSpace.each_object do |o|
        # we can't index the class itself as you can have anonymous classes, and doing so would prevent them from being GCd
        # We can't use the class name as by calling `to_s` we create a new object, which ObjectSpace.each_object will pick up (even though we're in the middle of it)
        # so we use the object id, and during the report phase, we generate an class ID-to-name map
        object_counts[i][o.class.object_id] = (object_counts[i][o.class.object_id] || 0) + 1
      end
    end
    GC.enable

    id_map = {}
    ObjectSpace.each_object(Class) do |o|
      id_map[o.object_id] = o.to_s
    end

    leaks = {}

    object_counts[1].each do |class_id,count|
      count_run_0 = object_counts[0][class_id] || 0
      next if count == count_run_0

      leaks[id_map[class_id] || class_id] = count - count_run_0
    end

    leaks
  end
end
