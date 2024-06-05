# frozen_string_literal: true

module Ml
  module Forest
    module Service
      class Mock
        def initialize() end

        def split_point(data)
          min, max = data.data.map { |x| x[0] }.minmax
          (min + max) / 2.0
        end

        def decision_function(sp)
          ->(x) { x[0] < sp }
        end

        def decision(element, split_point_d)
          decision_function(split_point_d).call(element)
        end

        def group(data, split_point)
          res = { true => [], false => [] }.merge(data.data.group_by(&decision_function(split_point)))

          {
            true => Data.define(:data).new(data: res[true]),
            false => Data.define(:data).new(data: res[false])
          }
        end

        def get_sample(data, _)
          Data.define(:data).new(data)
        end

        def end_condition(data)
          data.data.length <= 1
        end

        def evaulate_score(data)
          pp "MOCK - NOT IMPLEMENTED"
          data
        end
        
      end
    end
  end
end
