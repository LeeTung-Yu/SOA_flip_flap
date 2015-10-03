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
    hash_temp.shift
    hash_temp.each do |line|
      value = line.chop.split("\t")
      temp = {}
      header.each_index { |x| temp[header[x]] = value[x] }
      hash.push(temp)
    end
    @data = hash
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    first_item = @data[0]
    header_info = []
    first_item.each_key { | key | header_info.push(key) }
    content = ''
    content << header_info.reduce { |n1,n2| "#{n1}\t#{n2}" } + "\n"
    content_info = []
    @data.each_index do |row|
      item_arr = @data[row]
      item_arr.each_value { |value| content_info.push(value)}
      content << content_info.reduce { |n1,n2| "#{n1}\t#{n2}" } + "\n"
    end
    content
  end
end
