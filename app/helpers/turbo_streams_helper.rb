module TurboStreamsHelper
  def advanced_redirect(url)
    turbo_stream_action_tag(:advanced_redirect, url: url)
  end
end

Turbo::Streams::TagBuilder.prepend(TurboStreamsHelper)