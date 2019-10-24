%w(httpd mariadb-server unzip git vim).each do |p|
    package p do
        action :install
    end
end