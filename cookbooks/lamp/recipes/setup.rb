%w(httpd mariadb-server unzip git vim).each do |p|
    package p do
        action :install
    end
end
execute "epel" do
    commannd 'rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm'
end
execute "webtatic" do
    rpm -Uvh 'https://mirror.webtatic.com/yum/el7/webtatic-release.rpm'
end