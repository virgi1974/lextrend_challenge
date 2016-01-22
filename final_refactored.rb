module File_reader
  def read
    string_file = IO.read(@file)
    array_lines = string_file.split("\n")
    array_lines.map! { |elem| elem.split(",") }
    array_nums = array_lines.flatten.map {|elem| elem.to_i }
    array_sliced = array_nums.each_slice(2).to_a 

    return array_sliced
  end
end

class Arranger

  include File_reader

  def initialize file
    @file = file
    @data_a = read()
    @each_match = []
    @final_result = []
  end

  def init
    order_data()
    find_solution()
    show_best_solutions()
  end

  private

    def find_solution
      @data_a.each do |mini_a|
        index = @data_a.index(mini_a) 
        find_all(index)
        @final_result.last.unshift(mini_a)  
        @each_match = []
      end
    end

    def show_best_solutions
      order_best_solutions()
      max_size = @final_result.first.count
      solutions = @final_result.select { |solution| solution.size == max_size}

      puts "The besto solutions for this data-set are ...."
      solutions.map do |sol| 
        print sol
        puts "\n"
      end

    end

    def order_best_solutions
      @final_result.sort! do |x,y| 
        y.size <=> x.size 
      end
    end

    def order_data
      sort_by_heigth()
      @data_a = sort_by_same_height()
    end

    def sort_by_heigth
      @data_a.sort! do |x,y| 
        x[0] <=> y[0] 
      end
    end

    def sort_by_same_height 
      array_sort = []
      @data_a.each_index do|i| 

        if i < (@data_a.size-1)
          if ( (@data_a[i][0] == @data_a[i+1][0]) && (@data_a[i][1] < @data_a[i+1][1]) )
            array_sort << @data_a[i]
          elsif ( (@data_a[i][0] == @data_a[i+1][0]) && (@data_a[i][1] > @data_a[i+1][1]) )
            array_sort << @data_a[i+1]
            @data_a[i+1] = @data_a[i]
          else
            array_sort << @data_a[i]
          end
        elsif (i == @data_a.size-1)
          array_sort << @data_a[i]
        end
         
      end
      array_sort
    end

    def find_all current_index
        #valor del elemento desde el que lanzamos la comparacion
        reference = @data_a[current_index][1] 
        #elementos de @data que cumplen tener peso > reference
        candidates = find_vals_above(reference,current_index) 

        #condicion de salida para dar por finalizada esa combinacion
        if candidates == [] 
          @final_result << @each_match
          return
        end

        #indices de los matches
        candidates_indexes = find_index_matches(candidates) 
        #num de elements con valor superior
        values_above = num_values_above(candidates,candidates_indexes) 
        # result == [mini_a,index]
        result = get_best_match(candidates,values_above) 

        #guardado parcial de cada solucion
        @each_match << result[0]

        #si llegamos al ultimo elemento salimos o...
        if @data_a.size == result[1]+1
          @final_result << @each_match
        #... seguimos buscando resultados 
        else
          find_all(result[1])
        end
    end

    def find_vals_above reference,index
     temp = @data_a[index..-1].select { |l| l[1] > reference}
    end

    def find_index_matches matches
      indexes_candidates = []

      matches.each do |elem|
        indexes_candidates << @data_a.index(elem)
      end

      return indexes_candidates
    end

    def num_values_above candidates,indexes_candidates
      values_above = []

      candidates.each_with_index do |l,index|
        from = indexes_candidates[index]
        values_above << @data_a[from..-1].select { |elem| elem[1] > l[1]}.count
      end

      return values_above
    end

    def get_best_match candidates,values_above
      max_val = values_above.max 
      #I ONLY get the first result with maximum number of higher values above itself!!!!! 
      index_best_match = values_above.index(max_val)
      best_match = candidates[index_best_match]
      index_result = @data_a.index(best_match) 

      return [best_match,index_result]
    end

end

solution = Arranger.new('data.txt')
solution.init()


