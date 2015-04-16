#!/bin/bash
source /usr/local/rvm/environments/ruby-2.1.3
cd /var/www/sitefoil/current
RAILS_ENV=production rake on_cron