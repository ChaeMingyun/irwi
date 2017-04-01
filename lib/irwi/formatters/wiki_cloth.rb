class Irwi::Formatters::WikiCloth
  def initialize
    require 'wikicloth'
  end

  def format(text)
    # to_html : Rails APIDock에 없음
    WikiCloth::Parser.new(data: text).to_html
  end
end
