#!/bin/bash

cp init.sh /usr/bin/eden_init
chmod a+x /usr/bin/eden_init
cp run.sh /usr/bin/eden_run
chmod a+x /usr/bin/eden_run
cp env.sh /usr/bin/eden_env
chmod a+x /usr/bin/eden_env
cp config.sh /usr/bin/eden_config
chmod a+x /usr/bin/eden_config
cp navigate.sh /usr/bin/eden_navigate
chmod a+x /usr/bin/eden_navigate

cp bash_completion /etc/bash_completion.d/eden
cp edenconfig /etc/edenconfig


