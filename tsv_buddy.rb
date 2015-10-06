# Module that can be included (mixin) to create and parse TSV data
module TsvBuddy
  # @data should be a data structure that stores information
  #  from TSV or Yaml files. For example, it could be an Array of Hashes.
  attr_accessor :data

  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    hash = []
    hash_temp = []
    tsv.each_line { |line| hash_temp << line}
    header = hash_temp[0].chop.split("\t")
    # each key store in header
    hash_temp.shift
    hash_temp.each do |line|
      value = line.chop.split("\t")
      temp = {}
      header.each_index { |x| temp[header[x]] = value[x] }
      hash.push(temp)
    end
    @data = hash
  end

  def take_tsv_c(tsv)
  #Suggestions
  #-Search for methods that do not require you to create empty variables.
  #-Run rubocop on your code.
  #-Whenever possible, try to use 10 lines of code or less in your methods
  tsv_arr = tsv.lines
  header = tsv_arr[0].chop.split("\t")
  tsv_arr.shift
  @data = tsv_arr.map do |line|
    value = line.chop.split("\t")
    (header.zip(value)).to_h
  end
end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    header_item = @data[0]
    header_info = []
    header_item.each_key { | key | header_info.push(key) }
    content = ""
    content << header_info[0]
    header_info.shift
    content << header_info.each { |n1| content << "\t" + n1 } + "\n"
    # title finished
    content_info = []
    @data.each do |row|
      item_arr = @data[row]
      item_arr.each_value { |value| content_info.push(value)}
      content << content_info[0]
      content_info.shift
      content << content_info.each { |n1| content << "\t" + n1 } + "\n"
    end
    # content finished
    content
  end
end
