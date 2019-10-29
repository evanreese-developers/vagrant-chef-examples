#note we are using the mysql password even though this is mariadb as it is being used in LAMP Stack
mariadb_config = search(:passwords, "id:mysql").first
bash 'configure mariadb' do
    code <<- EOT
    mysqladmin -u mariadb_config['user'] password '#{mariadb_config['password']}'

    EOT