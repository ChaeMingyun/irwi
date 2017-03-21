module Irwi::Support::TemplateFinder
  def template_dir(template)
    dir = respond_to?(:controller_path) ? controller_path : controller.controller_path
    # view 파일을 Customize 하기 위해 만들었으면 그걸 쓰고, 아니라면 Gem 안에 있는 뷰 파일을 쓴다.
    dir = 'base_wiki_pages' if Dir.glob("app/views/#{dir}/#{template}.html.*").empty? # Select default if there are no template in resource directory
    dir
  end
end
