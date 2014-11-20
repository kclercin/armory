module Armory
  module Enumerable
    include ::Enumerable

    # @return [Enumerator]
    def each(start = 0)
      return to_enum(:each, start) unless block_given?
      Array(@collection[start..-1]).each do |element|
        yield(element)
      end
      unless last?
        start = [@collection.size, start].max
        fetch_next_page
        each(start, &Proc.new)
      end
      self
    end

    def count
      @collection.count
    end

    def last
      @collection.last
    end

  private

    # @return [Boolean]
    def last?
      true
    end
  end
end
