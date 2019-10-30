#note we are using the mysql password even though this is mariadb as it is being used in LAMP Stack
mariadb_config_root = data_bag_item('maria_db_config', 'user_root')
mariadb_config_webuser = data_bag_item('maria_db_config', 'user_webuser')
bash 'configure mariadb' do
    code <<-EOT
    mysqladmin -u #{mariadb_config_root['user']} password '#{mariadb_config_root['password']}'
    mysql -u #{mariadb_config_root['user']} --password=#{mariadb_config_root['password']} -e "UPDATE mysql.user SET Password=PASSWORD('#{mariadb_config_root['password']}' WHERE User ='root'"
    mysql -u #{mariadb_config_root['user']} --password=#{mariadb_config_root['password']} -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
    mysql -u #{mariadb_config_root['user']} --password=#{mariadb_config_root['password']} -e "DELETE FROM mysql.user WHERE User=''"
    mysql -u #{mariadb_config_root['user']} --password=#{mariadb_config_root['password']} -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
    mysql -u #{mariadb_config_root['user']} --password=#{mariadb_config_root['password']} -e "FLUSH PRIVILEGES"
    EOT
end
template '/tmp/codeigniter.sql' do
    source 'codeigniter.sql.erb'
    variables ({
        :database_name => mariadb_config_webuser['database'],
        :database_user => mariadb_config_webuser['user'],
        :database_password => mariadb_config_webuser['password']
    })
end