# frozen_string_literal

class AppName
  def initialize(app, app_name)
    @app = app
    @app_name = app_name
  end

  def call(env)
    if env['ORIGINAL_FULLPATH'] == '/'
      ['200', { 'Content-Type' => 'text/html' }, ['Dashboard!']]
    else
      status, headers, response = @app.call(env)
      headers.merge!({ 'X-App-Name' => @app_name.to_s })
      [status, headers, [response.body]]
    end
  end
end

