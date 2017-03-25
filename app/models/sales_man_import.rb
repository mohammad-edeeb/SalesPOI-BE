class SalesManImport
  # switch to ActiveModel::Model in Rails 4
  include ActiveModel::Model

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def save
    if imported_sales_men.map(&:valid?).all?
      SalesMan.delete_all
      imported_sales_men.each(&:save!)
      true
    else
      imported_sales_men.each_with_index do |sales_man, index|
        sales_man.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_sales_men
    @imported_sales_men ||= load_imported_sales_men
  end

  def load_imported_sales_men
    spreadsheet = open_spreadsheet
    (2..spreadsheet.last_row).map do |i|
      row_data = spreadsheet.row(i)
      sales_man = SalesMan.new(:username => row_data[0], :password => row_data[1])
      sales_man
    end
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
