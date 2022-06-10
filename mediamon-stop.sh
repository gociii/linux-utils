#!/bin/bash

pkill -P `cat /var/run/mediamon.sh.pid`
rm /var/run/mediamon.sh.pid
