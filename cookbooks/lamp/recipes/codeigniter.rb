mariadb_config_webuser = data_bag_item('maria_db_config', 'user_webuser')

remote_file '/tmp/codeigniter_source.zip' do
  source "https://github.com/bcit-ci/CodeIgniter/archive/3.1.11.zip"
end
bash "unzip CodeIgniter" do
    code <<-EOT
    rm -rf /var/www/html/{*,.*}
    unzip /tmp/codeigniter_source.zip -d /tmp/
    mv /tmp/CodeIgniter-*/{*,.*} /var/www/html/
    chown -R vagrant:vagrant /var/www/html
    EOT
end
template '/var/www/html/application/config/database.php' do
    source 'database.php.erb'
    variables ({
        :database_name => mariadb_config_webuser['database'],
        :database_user => mariadb_config_webuser['user'],
        :database_password => mariadb_config_webuser['password']
    })
end