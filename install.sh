#!/bin/bash

cp create.sh /usr/bin/eden_create
chmod a+x /usr/bin/eden_create
cp run.sh /usr/bin/eden_run
chmod a+x /usr/bin/eden_run
cp load.sh /usr/bin/eden_load
chmod a+x /usr/bin/eden_load
cp config.sh /usr/bin/eden_config
chmod a+x /usr/bin/eden_config

cp bash_completion /etc/bash_completion.d/eden
