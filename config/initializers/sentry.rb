# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = ENV.fetch('SENTRY_DSN', nil)

  config.enabled_environments = ['production']

  config.breadcrumbs_logger = %i[active_support_logger http_logger]
  config.traces_sample_rate = 1.0 # 0.0 to 1.0
  config.before_send = lambda do |event, _hint|
    event
  end
end
