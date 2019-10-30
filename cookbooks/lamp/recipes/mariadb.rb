#note we are using the mysql password even though this is mariadb as it is being used in LAMP Stack
mariadb_config = data_bag_item('passwords', 'mysql')
bash 'configure mariadb' do
    code <<-EOT
    mysqladmin -u #{mariadb_config['user']} password '#{mariadb_config['password']}'
    mysql -u #{mariadb_config['user']} --password=#{mariadb_config['password']} -e "UPDATE mysql.user SET Password=PASSWORD('#{mariadb_config['password']}' WHERE User ='root'"
    mysql -u #{mariadb_config['user']} --password=#{mariadb_config['password']} -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
    mysql -u #{mariadb_config['user']} --password=#{mariadb_config['password']} -e "DELETE FROM mysql.user WHERE User=''"
    mysql -u #{mariadb_config['user']} --password=#{mariadb_config['password']} -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
    mysql -u #{mariadb_config['user']} --password=#{mariadb_config['password']} -e "FLUSH PRIVILEGES"
    EOT
end