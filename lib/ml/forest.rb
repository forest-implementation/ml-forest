# frozen_string_literal: true

require_relative "forest/version"
require_relative "forest/node/node"

module Ml
  module Forest
    include Node
    class Tree
      attr_reader :trees, :forest_helper

      def initialize(
        data,
        forest_helper:,
        trees_count: 100
      )
        @forest_helper = forest_helper
        @trees = trees_count.times.map { |x| Node.init_from_data(forest_helper.get_sample(data, x), forest_helper: @forest_helper) }
      end

      def evaluate_forest(element)
        trees.map { |tree| Node.walk_nodes(tree, element, forest_helper: @forest_helper) }
      end

      def self.flat(tree)
        (tree.branches.values.map do |inout| 
          case inout
            in Node::OutNode
               inout.data
            in Node::InNode
              flat(inout)
          end
        end).flatten
      end 

      def fit_predict(data, forest_helper = @forest_helper)
        forest_helper.evaluate_score(evaluate_forest(data))
      end
    end
  end
end
