# Ml::Forest

Ml forest is the standalone implementation of forest.

To work properly, a service needs to be introduced (see https://github.com/forest-implementation/ml-service-sort)

## Installation

First get ruby (e.g. [rbenv](https://github.com/rbenv/rbenv)) and [bundler](https://bundler.io/docs.html)

(Optional) Create your gem

    $ bundle gem mygem

Add dependency for the forest

    $ bundle add ml-forest --github=forest-implementation/ml-forest

## Usage

In your file, import forest and service (we can leverage on the mocked service for now)

```Ruby
require "ml/forest"
require "ml/forest/service/mock"

forest = Ml::Forest::Tree.new([5, 8, 3, 4, 2, 7].map{|x| [x]} , trees_count: 1, forest_helper: Ml::Forest::Service::Mock.new)

pp forest.evaluate_forest([6])
pp forest.evaluate_forest([6.24])
```

## Test

    $ bundle exec rake test

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ml-forest.
