#!/bin/bash

. /usr/local/bin/env.sh && . /usr/local/bin/pre_start.sh && /usr/bin/supervisord -c /etc/supervisor.conf --nodaemon