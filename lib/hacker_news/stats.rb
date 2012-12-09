module HackerNews
  class Stats 

    attr_reader :items

    def initialize(items)
      @items = items.dup.sort! { |a,b| a['points'] <=> b['points'] }
    end

    # MEAN
    def mean
      return nil if @items.size < 1

      ((@items.inject(0) {|sum, n| sum += n['points']} / @items.size.to_f)*100).to_i/100.0
    end

    # MEDIAN
    def median
      return nil if @items.size < 1

      size = @items.size

      # if even items
      result = if size % 2 == 0
        (@items[size/2 - 1]['points'] + @items[size/2]['points']) / 2.0
      else
        @items[size/2]['points']
      end

      (result*100).to_i/100.0
    end

    # MODE without using an auxiliary array
    def mode
      return nil if @items.size < 1
      current = -1  # current value
      count   = 0   # number of occurences
      max     = 0   # Max number of occurences
      modes   = []  # values with  max number of occurences

      @items.each do |n|

        count += 1
        if current != n['points']
          if count > 1
            if count > max
              modes = [current]
              max = count
            elsif count == max
              modes << current
            end
          end

          current = n['points']
          count = 0
        end

      end

      modes.size == @items.size ? [] : modes

    end

    def items_above_median 
      @items.last(@items.size/2)
      #size = @items.size
      #idx = size % 2 == 0 ? size/2 : size/2 + 1 # index above median
      #(idx..size-1).map {|i| @items[i]}
    end
  end
end
