class { '::mysql::server':
      root_password    => 'password',
      override_options => { 'mysqld' => { 'bind_address' => '0.0.0.0' } }
      
      }