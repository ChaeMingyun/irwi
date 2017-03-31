=begin
이 파일은 기본적으로 헬퍼를 관리하는 파일이다.
irwi/helper 디렉토리에 적어놓은 헬퍼 파일을 autoload 시킨다.
그러고는 acts_as_wiki_pages_helper 메소드에 위에 불러온 헬퍼파일을 모두 include 시킨다.
=end
# autoload : 로드할 파일 위치 지정
module Irwi::Helpers
  autoload :WikiPagesHelper, 'irwi/helpers/wiki_pages_helper'
  autoload :WikiPageAttachmentsHelper, 'irwi/helpers/wiki_page_attachments_helper'
end

Module.class_eval do
  def acts_as_wiki_pages_helper(_config = {})
    include Irwi::Helpers::WikiPagesHelper
    include Irwi::Helpers::WikiPageAttachmentsHelper if Irwi.config.page_attachment_class_name
  end
end
