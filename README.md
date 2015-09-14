Setup Latinos framework
=======================

# Prepare Work Area

Exactly the same as for CVS (use version 4_2_8 for 7TeV analyses and 5_3_9 for 8TeV and 7_X_Y for 13TeV) 

    source $VO_CMS_SW_DIR/cmsset_default.(csh|sh)
    cmsrel CMSSW_X_Y_Z
    cd CMSSW_X_Y_Z/src
    cmsenv
    git cms-init

# Checkout Code

Clone the setup repository from GitHub (replace Z by 7 or 8 or 13 and make sure your SSH keys are setup at GitHub otherwise you'll have to type your password many times) 

    git clone --branch ZTeV git@github.com:latinos/setup.git LatinosSetup

For example:

    git clone --branch 7TeV git@github.com:latinos/setup.git LatinosSetup

    git clone --branch 8TeV git@github.com:latinos/setup.git LatinosSetup

    git clone --branch 13TeV git@github.com:latinos/setup.git LatinosSetup

And run the setup script

    source LatinosSetup/Setup.sh

For datacard maker setup only:

    source LatinosSetup/SetupShapeOnly.sh


# Commit changes

Make sure you are in the right repository/folder (for WWAnalysis or HWWAnalysis).

Do a git commit (or maybe git add first; see general git infos).

Make sure everything is how you wanted it (e.g. look at the commit history).

Do a git push to push the changes to GitHub.

If you want to put major changes in externals, please ask for the best way to do this.


# How to run skim

See https://github.com/latinos/LatinoTrees and the related README.md files,
in particular:

    https://github.com/latinos/LatinoTrees/tree/master/AnalysisStep/test



