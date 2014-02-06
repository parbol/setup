Setup Latinos framework
=======================

Documentation also in

    http://www.t2.ucsd.edu/twiki2/bin/view/Latinos/GitSetup

# Introduction

    As in CVS we are using a setup script that checks out external dependencies
    Currently we are using historical imports from the CVS servers; if you need anything new (CMSSW 6/7) in an external, please ask before trying to set it up
    We have two main repositories that we develop in the WWAnalysis package (from Boris' old UserCode area) and the HWWAnalysis package (from Alessandro's old UserCode area) 


# Prepare Work Area

Exactly the same as for CVS (use version 4_2_8 for 7TeV analyses and 5_3_9 for 8TeV) 

    source $VO_CMS_SW_DIR/cmsset_default.(csh|sh)
    cmsrel CMSSW_X_Y_Z
    cd CMSSW_X_Y_Z/src
    cmsenv


# Checkout Code

Clone the setup repository from GitHub (replace Z by 7 or 8 and make sure your SSH keys are setup at GitHub otherwise you'll have to type your password many times) 

    git clone --branch ZTeV git@github.com:latinos/setup.git LatinosSetup

For example:

    git clone --branch 7TeV git@github.com:latinos/setup.git LatinosSetup

    git clone --branch 8TeV git@github.com:latinos/setup.git LatinosSetup

And run the setup script 

    source LatinosSetup/Setup.sh

For datacard maker setup only: 

    source LatinosSetup/SetupShapeOnly.sh


# Commit Changes

Make sure you are in the right repository/folder (for WWAnalysis or HWWAnalysis)

Do a git commit (or maybe git add first; see general git infos)

Make sure everything is how you wanted it (e.g. look at the commit history)

Do a git push to push the changes to GitHub

If you want to put major changes in externals, please ask for the best way to do this 




# how to run skim

    cd src/WWAnalysis/SkimStep/test
    cmsRun latinosYieldSkim.py print inputFiles=file:/data/amassiro/CMSSWRoot/Summer12/WWJetsTo2L2Nu_TuneZ2star_8TeV-madgraph-tauola/28DCA073-84D4-E111-A8D0-F04DA23BCE4C.root isMC=True globalTag=GR_R_52_V7  outputFile=/tmp/amassiro/latinosYieldSkim_MC_WWmg.root   correctMetPhi=False
    cmsRun latinosYieldSkim.py print inputFiles=file:/data/amassiro/CMSSWRoot/Summer12/GluGluToHHTo2B2WToLNuLNu_mH-125_8TeV-madgraph-pythia6-tauola_AODSIM_PU_S10_START53_V19-v1/4486E5A3-3EF7-E211-A407-0017A4770834.root  isMC=True globalTag=GR_R_52_V7  outputFile=/tmp/amassiro/latinosYieldSkim_MC_HH.root   correctMetPhi=False

# step23

for MC

    cd src/WWAnalysis/AnalysisStep/test/step3
    cmsRun step3.py print inputFiles=file:/tmp/amassiro/latinosYieldSkim_MC_WWmg.root  label=WW id=123456789  scale=1 outputFile=/tmp/amassiro/step3_latinosYieldSkim_MC_WWmg.root
    cmsRun step3.py print inputFiles=file:/tmp/amassiro/latinosYieldSkim_MC_HH.root    label=HH id=123456789  scale=1 outputFile=/tmp/amassiro/step3_latinosYieldSkim_MC_HH.root



for DATA

    cd src/WWAnalysis/AnalysisStep/test/step3
    cmsRun step3.py print inputFiles=file:data.root    label=MuEG id=1234 outputFile=latinosStep3_DATA_202075_VBF.root json=certifiedLatinos.53X.Moriond

label should be one of the following (used for "trigger" to avoid double counting):

    'SingleElectron', 'DoubleElectron', 'SingleMuon', 'DoubleMuon', 'MuEG'




# transform latino tree

    cd src/WWAnalysis/AnalysisStep/test/step3
    python ucsd2latino.py /tmp/amassiro/step3_latinosYieldSkim_MC_WWmg.root



