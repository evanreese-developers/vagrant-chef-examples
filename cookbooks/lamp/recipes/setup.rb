%w(httpd mariadb-server unzip git vim).each do |p|
    package p do
        action :install
    end
end
execute "epel" do
    not_if "rpm -qa | grep epel"
    command 'rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm'
end
execute "webtatic" do
    not_if "rpm -qa | grep webtatic"
    command 'rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm'
end