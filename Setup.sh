if [ -z $CMSSW_BASE ]; then
    echo "======================================="
    echo "No CMS environment detected; stopping..."
    echo "======================================="
    exit 1
fi

source $CMSSW_BASE/src/LatinosSetup/Functions.sh

if [[ "$CMSSW_VERSION" == CMSSW_4_2_8* ]]; then

    echo "======================================="
    echo "running with $CMSSW_VERSION - this is a 7 TeV setup!"
    echo "Current Time:" $(date)
    echo "checking out additional repositories; this could take a while ..."
    echo "======================================="

    echo " - Basic Code"

    github-addext latinos/WWAnalysis.git WWAnalysis
    github-addext latinos/HWWAnalysis.git HWWAnalysis

    github-addext latinos/RecoEgamma-ElectronIdentification.git RecoEgamma/ElectronIdentification RecoEgamma-ElectronIdentification-V00-03-30
    (
	cd RecoEgamma/ElectronIdentification
	git checkout --quiet RecoEgamma-ElectronIdentification-V00-03-33 python/cutsInCategoriesHZZElectronIdentificationV06_cfi.py
    )

    github-addext latinos/HiggsAnalysis-HiggsToWW2Leptons.git HiggsAnalysis/HiggsToWW2Leptons For2011-October-21st-reload
    github-addext latinos/UserCode-MitPhysics-data-ElectronMVAWeights.git HiggsAnalysis/HiggsToWW2Leptons/data/ElectronMVAWeights HWW_V1
    github-addext latinos/UserCode-sixie-Muon-MuonAnalysisTools.git Muon/MuonAnalysisTools V00-00-10
    github-addext latinos/UserCode-EGamma-EGammaAnalysisTools.git EGamma/EGammaAnalysisTools V00-00-30-BP42X
    github-addext latinos/UserCode-EGamma-EgammaCalibratedGsfElectrons.git EgammaCalibratedGsfElectrons Shervin13062012_2012Prompt_and_May23ReReco_and_Summer12MC_smearing_V00

    github-addext latinos/RecoEgamma-EgammaTools.git RecoEgamma/EgammaTools RecoEgamma-EgammaTools-CMSSW_4_2_8
    (
	cd RecoEgamma/EgammaTools
	git checkout --quiet RecoEgamma-EgammaTools-CMSSW_5_2_4 src/EcalClusterLocal.cc
	git checkout --quiet RecoEgamma-EgammaTools-CMSSW_5_2_4 interface/EcalClusterLocal.h
    )

    github-addext latinos/CondFormats-EgammaObjects.git CondFormats/EgammaObjects CondFormats-EgammaObjects-V00-04-01
    github-addext latinos/UserCode-sixie-patches-RecoEcal-EgammaCoreTools.git RecoEcal/EgammaCoreTools HZZ4L_HCP2012_42X

    github-addext latinos/HiggsAnalysis-CombinedLimit.git HiggsAnalysis/CombinedLimit HiggsAnalysis-CombinedLimit-V01-13-02
    github-addext latinos/RecoJets-Configuration.git RecoJets/Configuration RecoJets-Configuration-V02-04-16
    github-addext latinos/RecoJets-JetAlgorithms.git RecoJets/JetAlgorithms RecoJets-JetAlgorithms-V04-01-00
    github-addext latinos/RecoJets-JetProducers.git RecoJets/JetProducers RecoJets-JetProducers-V05-05-03
    github-addext latinos/PhysicsTools-Utilities.git PhysicsTools/Utilities PhysicsTools-Utilities-V08-03-09
    github-addext latinos/GeneratorInterface-GenFilters.git GeneratorInterface/GenFilters GeneratorInterface-GenFilters-CMSSW_4_2_8_patch7
    
    github-addext latinos/UserCode-CMG-CMGTools-External.git CMGTools/External V00-02-10
    github-addext latinos/DataFormats-PatCandidates.git DataFormats/PatCandidates DataFormats-PatCandidates-$CMSSW_VERSION
    (
	cd DataFormats/PatCandidates
	git checkout --quiet d29158e1ba064aa5bcc524dba4e4bc6a1b096c06 src/TriggerObjectStandAlone.cc
    )

    echo " - Get UserData in pat::PFParticle";
    github-addext latinos/PhysicsTools-PatAlgos.git PhysicsTools/PatAlgos PhysicsTools-PatAlgos-$CMSSW_VERSION
    (
	cd PhysicsTools/PatAlgos
	git checkout --quiet 2c6034a1f342f1286fd2a51eff9062bef79995cf plugins/PATPFParticleProducer.cc
	git checkout --quiet 2c6034a1f342f1286fd2a51eff9062bef79995cf plugins/PATPFParticleProducer.h
	git checkout --quiet 82c8dd0a16a4eac6286eda4a7297cc90ed2a4798 plugins/PATCleaner.cc
    )

    echo " - Stuff for ghost muon cleaning" ;
    github-addext latinos/DataFormats-MuonReco.git DataFormats/MuonReco DataFormats-MuonReco-U09-00-00-01

    echo " - Stuff to run all the MEs" ;
    github-addext latinos/UserCode-Snowball-Higgs-Higgs_CS_and_Width.git Higgs/Higgs_CS_and_Width V00-03-01
    github-addext latinos/UserCode-HZZ4L_Combination-CombinationPy.git HZZ4L_Combination/CombinationPy MoriondInputsV8
    github-addext latinos/UserCode-CJLST-ZZMatrixElement-MELA.git ZZMatrixElement/MELA V00-01-26
    github-addext latinos/UserCode-UFL-ZZMatrixElement-MEKD.git ZZMatrixElement/MEKD V00-01-04
    github-addext latinos/UserCode-HZZ4l_MEM-ZZMatrixElement-MEMCalculators.git ZZMatrixElement/MEMCalculators V00-00-09
    
    CURDIR=$PWD
    echo " - Need to tar some of the ME folders to ship them when running CRAB -- files stored in WWAnalysis/AnalysisStep/crab";
    cd $CMSSW_BASE/src/Higgs/Higgs_CS_and_Width;
    tar czf txtFiles.tar.gz txtFiles;
    mv txtFiles.tar.gz $CMSSW_BASE/src/WWAnalysis/AnalysisStep/crab/;
    cd $CMSSW_BASE/src/HZZ4L_Combination/CombinationPy;
    mkdir tmp;
    cd tmp;
    mkdir CreateDatacards;
    cp -r ../CreateDatacards/SM_inputs* ./CreateDatacards;
    tar czf CreateDatacards.tar.gz CreateDatacards;
    cd ../;
    mv tmp/CreateDatacards.tar.gz $CMSSW_BASE/src/WWAnalysis/AnalysisStep/crab/;
    rm -r tmp;
    cd $CMSSW_BASE/src/ZZMatrixElement/MEKD/src;
    tar czf Cards.tar.gz Cards;
    tar czf PDFTables.tar.gz PDFTables;
    mv Cards.tar.gz $CMSSW_BASE/src/WWAnalysis/AnalysisStep/crab/;
    mv  PDFTables.tar.gz $CMSSW_BASE/src/WWAnalysis/AnalysisStep/crab/;
    cd $CURDIR

    echo "======================================="
    echo " ... Done.                             "
    echo "Current Time:" $(date)
    echo "======================================="

else
    echo "======================================="
    echo "You are using release $CMSSW_VERSION which is not supported by this script."
    echo "This script only supports the 7TeV analysis with CMSSW_4_2_8*."
    echo "If you intended to setup an 8TeV analysis please switch to the correct branch of the setup repository"
    echo "using 'cd $CMSSW_BASE/LatinosSetup && git checkout 8TeV"
    echo "======================================="
fi;
