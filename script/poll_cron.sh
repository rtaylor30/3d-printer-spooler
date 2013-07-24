#!/bin/bash

cd /home/3dev/3d-printer-spooler
echo "Executing poller\n" >> log/poller.log
source /usr/local/rvm/environments/ruby-1.9.3-p429
RAILS_ENV=production bundle exec rake app:poll >> log/poller.log

