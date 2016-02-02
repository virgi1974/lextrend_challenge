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