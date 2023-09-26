# frozen_string_literal: true

module Node
  def self.init_from_data(data, minmaxgroups = data.data.transpose.map(&:minmax).transpose, forest_helper:)
    return OutNode.new(data, minmaxgroups) if forest_helper.end_condition(data)

    split_point = forest_helper.split_point(data)
    node_groups = forest_helper.group(data, split_point)

    InNode.new(
      node_groups.transform_values do |group|
        minmaxgroup = group.data.transpose.map(&:minmax).transpose
        init_from_data(group, minmaxgroup, forest_helper: forest_helper)
      end,
      split_point,
      minmaxgroups
    )
  end

  def self.walk_nodes(node, element, forest_helper:)
    return node.data if node.is_a?(OutNode)

    # a key of next branch
    next_branch_key = forest_helper.decision(element, node.split_point)
    walk_nodes(node.branches[next_branch_key], element, forest_helper: forest_helper)
  end

  OutNode = Data.define(:data, :minmaxborders) do
    def to_a
      data
    end
  end

  InNode = Data.define(:branches, :split_point, :minmaxborders) do
    def to_a
      branches.values.map(&:to_a)
    end

    def to_h
      branches.values.map(&:to_h)
    end
  end
end
