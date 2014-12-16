if [ -z $CMSSW_BASE ]; then
    echo "======================================="
    echo "No CMS environment detected; stopping..."
    echo "======================================="
    exit 1
fi

source $CMSSW_BASE/src/LatinosSetup/Functions.sh

if [[ "$CMSSW_VERSION" == CMSSW_5_*_*  ||  "$CMSSW_VERSION" == CMSSW_6_2_* ]]; then

    echo "======================================="
    echo "  running with $CMSSW_VERSION - this is an 8 TeV setup!"
    echo "  Current Time:" $(date)
    echo "  checking out additional repositories; this could take a while ..."
    echo "  Only shape analysis toolkit will be setup"
    echo "  Please use Setup.sh for the full package"
    echo "       export SCRAM_ARCH=slc5_amd64_gcc472"
    echo "======================================="

    echo " - Basic Code"

    github-addext latinos/HWWAnalysis.git HWWAnalysis

    if [[ "$CMSSW_VERSION" == CMSSW_5_*_* ]]; then
        github-addext latinos/HiggsAnalysis-CombinedLimit.git HiggsAnalysis/CombinedLimit HiggsAnalysis-CombinedLimit-V02-06-00
    fi

    echo "======================================="
    echo " ... Done.                             "
    echo "Current Time:" $(date)
    echo "======================================="

else
    echo "======================================="
    echo "You are using release $CMSSW_VERSION which is not supported by this script."
    echo "A with CMSSW_5_*_* release is suggested for shape"
    echo "======================================="
fi;
