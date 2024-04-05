module ApplicationHelper
  include Pagy::Frontend

  def inline_errors(object, attribute)
    return if object.errors[attribute].none?

    content_tag :p, object.errors[attribute].join(', '), class: 'text-red-500 text-xs block'
  end

  def text_field_css(object, attribute)
    'border-red-500' if object.errors[attribute].any?
  end

  def render_turbo_stream_flash_messages
    turbo_stream.prepend 'flash', partial: 'shared/flash'
  end
end
