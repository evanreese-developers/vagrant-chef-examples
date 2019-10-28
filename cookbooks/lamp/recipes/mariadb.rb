mariadb_config = search(:passwords, "id:mysql").first
bash 'configure mariadb' do
    code <<- EOT
    mysqladmin -u mariadb_config['user'] password '#{mariadb_config['password']}'

    EOT