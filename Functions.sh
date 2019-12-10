#!/bin/bash

github-addext() {

    git clone --quiet git@github.com:$1 $2
    if [ ! -z $3 ]; then
	(
	    cd $2
	    git checkout --quiet $3
	)
    fi

}


github-addext-http() {

    git clone --quiet https://github.com/$1 $2
    if [ ! -z $3 ]; then
        (
            cd $2
            git checkout --quiet $3
        )
    fi

}

