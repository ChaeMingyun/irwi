module Irwi::Extensions::Models::WikiPageAttachment
  extend ActiveSupport::Concern
  # freeze : 3.2.13버전 이전 레일즈에만 나타나는 메소드
  #          
  DEFAULT_PAPERCLIP_OPTIONS = {styles: {medium: "300x300>", thumb: "100x100>"}}.freeze

  included do
    belongs_to :page, class_name: Irwi.config.page_class_name
  end
end
