ActiveSupport::Reloader.to_prepare do
  $RUBYCOIN = Core::Node.instance
end
