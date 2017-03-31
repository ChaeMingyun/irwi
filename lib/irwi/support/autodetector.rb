require 'active_support/concern'

module Irwi::Support::Autodetector
  extend ActiveSupport::Concern

  included do
    const_get(:PROVIDERS).each do |fmt|
      autoload fmt.classify.to_sym, "#{name.underscore}/#{fmt}"
    end
  end

  module ClassMethods
    def autodetect
      const_get(:PROVIDERS).each do |f|
        begin
          # classify(table_name) : 복수의 테이블로부터 클래스 이름을 생성
          # => PROVIDERS에서 받아온 const_get테이블 들에서 이름을 받아옴
          return const_get(f.classify).new
          # rescue
        rescue LoadError
        end
      end
    end
  end
end
