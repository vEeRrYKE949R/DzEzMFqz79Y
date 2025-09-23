# 代码生成时间: 2025-09-24 00:46:44
# ExcelGenerator is a service class for creating Excel files.
class ExcelGenerator
  # Initialize with a filename and data to be written into the Excel file.
  #
  # @param filename [String] The name of the Excel file to create.
  # @param data [Array<Array>] The data to be written into the Excel file.
  def initialize(filename, data)
    @filename = filename
    @data = data
  end

  # Generate the Excel file using the Roo gem.
  #
  # @return [String] The path to the generated Excel file.
  def generate
    begin
      excel = Roo::Spreadsheet.open(nil, nil, create: true)
      excel.add_sheet('Sheet 1')
      @data.each_with_index do |row, index|
        excel.row(index + 1).add(row)
      end
      excel.save(@filename)
    rescue => e
      # Handle any exceptions that occur during the generation of the Excel file.
      puts "Error generating Excel file: #{e.message}"
      nil
    end
  end
end

# Usage example:
# Create an instance of ExcelGenerator with some sample data.
# data = [["Header 1", "Header 2"], ["Row 1, Column 1", "Row 1, Column 2"], ["Row 2, Column 1", "Row 2, Column 2"]]
# generator = ExcelGenerator.new('example.xlsx', data)
# generator.generate
