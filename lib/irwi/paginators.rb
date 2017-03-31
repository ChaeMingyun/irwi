module Irwi::Paginators
  # Available formatters in order of their priority
  # %w 문자열 배열
  PROVIDERS = %w(will_paginate kaminari none).freeze

  include Irwi::Support::Autodetector
end
