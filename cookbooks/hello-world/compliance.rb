['telnet','telnet-client'].each do |p|
  package p do
    action :remove
  end
end

file "/welcome" do
  action :delete
end
