# Class: monit::params
#
# This module manages Monit paramaters
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class monit::params {

  # OS Specific variables
  case $::osfamily {
    'RedHat': {
      $conf_file          = '/etc/monit.conf'
      $conf_dir           = '/etc/monit.d'
      $default_conf       = undef
      $monit_package      = 'monit'
      $monit_service      = 'monit'
      $id_dir             = '/var/lib/monit'
      $idfile             = '/var/lib/monit/id'
      $logfile            = '/var/log/monit'
      $logrotate_script   = '/etc/logrotate.d/monit'
      $logrotate_source   = 'logrotate.redhat.erb'
      $service_has_status = true
      $default_conf_tpl   = undef
    }
    'Debian': {
      $conf_file        = '/etc/monit/monitrc'
      $conf_dir         = '/etc/monit/conf.d'
      $default_conf     = '/etc/default/monit'
      $monit_package    = 'monit'
      $monit_service    = 'monit'
      $id_dir           = '/var/lib/monit'
      $idfile           = '/var/lib/monit/id'
      $logfile          = '/var/log/monit.log'
      $logrotate_script = '/etc/logrotate.d/monit'
      case $::operatingsystem {
        'Debian': {
          case $::lsbdistcodename {
            'squeeze': { $service_has_status = false }
            default:   { $service_has_status = true }
          }
          $logrotate_source = 'logrotate.debian.erb'
          if $::lsbdistcodename == 'jessie' {
            $default_conf_tpl = 'monit.default.conf.debian.jessie.erb'
          } else {
            $default_conf_tpl = 'monit.default.conf.ubuntu.maverick.erb'
          }
        }
        'Ubuntu': {
          $logrotate_source   = 'logrotate.ubuntu.erb'

          case $::lsbdistrelease {
            '10.04': {
              $default_conf_tpl = 'monit.default.conf.ubuntu.lucid.erb'
              $service_has_status = false
            }
            '10.10': {
              $default_conf_tpl = 'monit.default.conf.ubuntu.maverick.erb'
              $service_has_status = false
            }
            '12.04': {
              $default_conf_tpl = 'monit.default.conf.ubuntu.precise.erb'
              $service_has_status = true
            }
            '12.10': {
              $default_conf_tpl = 'monit.default.conf.ubuntu.quantal.erb'
              $service_has_status = true
            }
            '13.04': {
              $default_conf_tpl = 'monit.default.conf.ubuntu.raring.erb'
              $service_has_status = true
            }
            '13.10': {
              $default_conf_tpl = 'monit.default.conf.ubuntu.saucy.erb'
              $service_has_status = true
            }
            '14.04': {
              $default_conf_tpl = 'monit.default.conf.ubuntu.trusty.erb'
              $service_has_status = true
            }
            '16.04': {
              $default_conf_tpl = 'monit.default.conf.ubuntu.xenial.erb'
              $service_has_status = true
            }
            default: {
              fail("Unsupported lsbdistid:${::lsbdistid}/${::lsbdistrelease}")
            }
          }
        }
      }
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }
  }
}
