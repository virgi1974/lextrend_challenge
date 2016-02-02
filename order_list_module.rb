module Order_list
  
def order_data
  sort_by_heigth()
  @data_a = sort_by_same_height()
end

private

  def sort_by_heigth
    @data_a.sort! do |x,y| 
      x[0] <=> y[0] 
    end
  end

  def sort_by_same_height 
    array_sort = []
    temp = ""

    @data_a.each do |key_val|
      if temp != key_val[0]
        
        selection = select_equal(key_val)
        selection = order_equal(selection)
        selection.each { |val| array_sort << val}

        temp = key_val[0]
      end
    end

    array_sort
  end

  def select_equal key_val
    @data_a.select { |elem| elem[0] == key_val[0]}
  end

  def order_equal selection
    selection.sort! do |x,y|
      x[1] <=> y[1] 
    end
  end

end