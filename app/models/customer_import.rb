class CustomerImport
  # switch to ActiveModel::Model in Rails 4
  include ActiveModel::Model

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def save
    if imported_customers.map(&:valid?).all?
      imported_customers.each(&:save!)
      true
    else
      imported_customers.each_with_index do |customer, index|
        customer.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_customers
    @imported_customers ||= load_imported_customers
  end

  def load_imported_customers
    spreadsheet = open_spreadsheet
    (2..spreadsheet.last_row).map do |i|
      row_data = Hash[[Customer.permitted_attrs, spreadsheet.row(i)].transpose]
      customer = Customer.new
      if row_data[:last_trx_amount].nil?
        customer.errors.add :base, "Null last trx amount"
      end
      customer.attributes = row_data
      customer
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
