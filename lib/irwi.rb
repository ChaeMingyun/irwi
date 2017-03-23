# active support를 오버라이딩하기 위해 불러온다
require 'active_support/dependencies'
# Gemfile에 있는 rails_autolink를 사용하기 위해 불러온다.
require 'rails_autolink' if defined?(Rails)

module Irwi
  module Support
    # View를 커스터마이제이션 한 경우 (rails g irwi_wiki_views) 그 파일을 가져다 쓰기 위해 작성된 파일
    autoload :TemplateFinder, 'irwi/support/template_finder'
    # 모르겠다ㅠ 수정요망
    autoload :Autodetector, 'irwi/support/autodetector'
  end

  module Comparators
    autoload :DiffLcs, 'irwi/comparators/diff_lcs'
    autoload :Base, 'irwi/comparators/base'
    module Spans
      autoload :ChangedSpan, 'irwi/comparators/spans/changed_span'
      autoload :NotChangedSpan, 'irwi/comparators/spans/not_changed_span'
    end
  end

  module Extensions
    ;
  end

  autoload :Formatters, 'irwi/formatters'
  autoload :Paginators, 'irwi/paginators'

  def self.config
    # config 변수가 없다면 Irwi::Config 클래스에 지정되어 있는 기본값을 따른다. 
    @config ||= Irwi::Config.new
  end
end

require 'irwi/extensions/controllers'
require 'irwi/extensions/models'
require 'irwi/support/route_mapper' # Routes
require 'irwi/helpers'
require 'irwi/config'

ActionController::Base.append_view_path File.expand_path('../../app/views', __FILE__) # Append default views
