class Rack::Attack
  # Limit 5 Logins every 60 seconds by IP
  Rack::Attack.throttle('limit logins by IP', limit: 5, period: 60) do |req|
    req.ip
  end

  Rack::Attack.throttled_response = lambda do |_env|
    # Using 503 because it may make attacker think that they have successfully
    # DOSed the site. Rack::Attack returns 429 for throttling by default
    html = ApplicationController.render(file: 'public/503.html', status: :service_unavailable, layout: false)
    [503, { 'Content-Type' => 'text/html' }, [html]]
  end
end
