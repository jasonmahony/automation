define apache::install {
  
    package { "$::apache::package": ensure => installed }

}