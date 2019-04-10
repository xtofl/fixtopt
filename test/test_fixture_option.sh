#!/bin/bash

# make sure we can run the tests from whereever the
# current working directory is
cd $(dirname $0)

export PYTHONPATH=$(realpath ../src)

(
    if [ -d /tmp/test_dir ]; then
        rm -rf /tmp/test_dir;
    fi
    mkdir /tmp/test_dir
    cd templates
    for file in $(ls); do
        cp $file /tmp/test_dir/${file/template_/}
    done
    (
        cd /tmp/test_dir

        set -x
        python3 -m pytest test_options.py --option1=user_provided || exit ${LINENO}

        echo '{"option1": "user_provided"}' > configfile
        python3 -m pytest test_options.py --config=configfile || exit ${LINENO}

        echo '{"option1": "config_provided"}' > configfile
        python3 -m pytest test_options.py --config=configfile --option1=user_provided || exit ${LINENO}
        python3 -m pytest test_options.py --config=configfile && exit ${LINENO}
        python3 -m pytest test_options.py --config=configfile  --option1=should_fail && exit ${LINENO}

        echo -e "\e[1m\e[32mTESTS SUCCEEDED\e[0m"
    ) || exit $?
) || (echo -e "\e[1;0;31mFAILURE on line $?\e[0m" && exit 1) || exit 1