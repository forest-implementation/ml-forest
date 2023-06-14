# frozen_string_literal: true

require "bundler/setup"
require "ml/forest"
require "ml/forest/services/mock"


puts "main"

input = [[1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [2, 2]]
#

forest = Ml::Forest::Tree.new([[1, 1], [2, 2], [3, 3], [7, 1000]], trees_count: 3, forest_helper: Ml::Forest::Services::Mock.new)
p forest.evaluate_forest([2, 2])
