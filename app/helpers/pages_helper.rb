module PagesHelper
  def display_receipt(basket)
    list = '<ul>'
    if basket
      basket.each do |line|
        list << "<li> #{line}</li>"
      end
      list << '</ul>'
    end
    list.html_safe
  end
end
