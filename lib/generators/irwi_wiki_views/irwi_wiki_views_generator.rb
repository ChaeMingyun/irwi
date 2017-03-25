class IrwiWikiViewsGenerator < Rails::Generators::Base
  # 앞에 ..으로 경로 생략 가능
  source_root File.expand_path("../../../../app/views/base_wiki_pages", __FILE__)
# resources: 와 같음
  def views
    empty_directory 'app/views/base_wiki_pages'
# page 폴더에 생성된 파일 배치
    Dir.foreach File.expand_path("../../../../app/views/base_wiki_pages", __FILE__) do |file| # Searching for files in app/views
      copy_file(file, 'app/views/base_wiki_pages/' + file) if file != '.' && file != '..'
    end
  end
end
