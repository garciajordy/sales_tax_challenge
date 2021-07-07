module BasketConcern
  extend ActiveSupport::Concern
  FILE_LINE_REGEXP = /\A(?<quantity>\d*) ?(?<name>.+) at (?<price>\d+.?\d*)/

  def get_document(file)
    read_file(file) if file
  end

  def read_file(file)
    @basket = []
    sales_taxes = 0
    total = 0
    File.open(file, 'r').each_line do |line|
      named_captures = line.match FILE_LINE_REGEXP
      name = named_captures[:name]
      category = Product.select { |product| name.include? product.name }&.first&.category
      quantity = named_captures[:quantity]
      price = named_captures[:price].to_f
      total += price
      sales_taxes += tax_calculator(price, name, category)
      @basket << "#{quantity} #{name}: #{price}"
    end
    total_and_sales_tax(@basket, total, sales_taxes)
  end

  def tax_calculator(price, name, category)
    total_tax = 0
    total_tax += price * 0.05 if name.include?('imported')
    total_tax += price * 0.10 if category.name == Category::OTHER
    total_tax.round(2)
  end

  def round_up(number)
    remainder = (number % 0.05).round(2)
    return number if remainder.zero?

    result = number + (0.05 - remainder)
    result.round(2)
  end

  def total_and_sales_tax(basket, total, tax)
    basket << "Sales Taxes: #{round_up(tax)}"
    basket << "Total: #{(total + round_up(tax)).round(2)}"
  end
end
