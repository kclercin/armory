module Armory
  module Utils

    # Returns a new array with the concatenated results of running block once for every element in enumerable.
    # If no block is given, an enumerator is returned instead.
    #
    # @param enumerable [Enumerable]
    # @return [Array, Enumerator]
    def flat_pmap(enumerable)
      return to_enum(:flat_pmap, enumerable) unless block_given?
      pmap(enumerable, &Proc.new).flatten!(1)
    end
    module_function :flat_pmap

    # Returns a new array with the results of running block once for every element in enumerable.
    # If no block is given, an enumerator is returned instead.
    #
    # @param enumerable [Enumerable]
    # @return [Array, Enumerator]
    def pmap(enumerable)
      return to_enum(:pmap, enumerable) unless block_given?
      if enumerable.count == 1
        enumerable.collect { |object| yield(object) }
      else
        enumerable.collect { |object| Thread.new { yield(object) } }.collect(&:value)
      end
    end
    module_function :pmap
  end
end
