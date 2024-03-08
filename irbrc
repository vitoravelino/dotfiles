if defined?(Reline::Face)
  Reline::Face.config(:completion_dialog) do |conf|
    conf.define(:default, foreground: "#dadbc0", background: "#242834")
    conf.define(:enhanced, foreground: "#dadbc0", background: "#3d4150")
    conf.define(:scrollbar, foreground: "#434957", background: "#434957")
  end
end

