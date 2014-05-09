Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
}


  include apache2
  include massiveapp
  include memcached
  include mysql
  include passenger
  
import "nodes.pp"