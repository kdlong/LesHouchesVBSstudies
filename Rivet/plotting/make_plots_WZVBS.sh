#!/bin/sh
# add 
#MGCENTRAL="'Title={MG5_aMC}:LineColor=red:ErrorBandColor=red:ErrorBands=1:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
#scale factor for MAXPTJ 1000*0.00032898427/0.00166447
MGEMMMAXPTJ="'Scale=197.651:Title={MG5_aMC $\mu=max(p_{Tj})$}:LineColor=red:ErrorBandColor=red:ErrorBands=1:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
MGEMMFIXED="'Scale=1000:Title={MG5_aMC+Pythia8}:LineColor=green:ErrorBandColor=green:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
VBFNLOPY="'Scale=1000:Title={VBFNLO+Pythia8}:LineColor=blue:ErrorBandColor=blue:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
VBFNLOHW="'Scale=1000:Title={VBFNLO+Herwig7}:LineColor=magenta:ErrorBandColor=magenta:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
VBFNLOHW_SO="'Scale=45199889:Title={VBFNLO+Herwig7 via LHE}:LineColor=orange:ErrorBandColor=orange:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
VBFNLOPYCUET="'Scale=1000:Title={VBFNLO+Pythia8 $\mu=M_W$ tune CUET}:LineColor=cyan:ErrorBandColor=cyan:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
SHERPA_DYN="'Scale=1000:Title={Sherpa $\mu=max(p_{Tj})$}:LineColor=orange:ErrorBandColor=orange:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
SHERPA="'Scale=1000:Title={Sherpa}:LineColor=cyan:ErrorBandColor=cyan:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
#MGFIXEDMZ="'Scale=0.431:Title={MG5_aMC $\mu=M_Z$}:LineColor=teal:ErrorBandColor=teal:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'" # Scale = 7.595/17.63

# filter the plots with the option -m 
comm_fixMW="rivet-mkhtml -n5 -o rivet-plots-MG-VBFNLO-FIXEDMW  -c style_WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/Wm.*OF.*" ../data/WmZTo1E1Nu2Mu_FixedScaleMW_LHConfig_VBFNLO-Pythia8.yoda:$VBFNLOPY ../data/WmZTo1E1Nu2Mu_FixedScaleMW_LHConfig_madgraph-pythia8.yoda:$MGEMMFIXED ../data/WmZTo1E1Nu2Mu_FixedScaleMW_LHConfig_VBFNLO-Herwig7.yoda:$VBFNLOHW ../data/VBS_WZ_MW_Sherpa.yoda:$SHERPA"

comm_fixMW_rebin="rivet-mkhtml -n5 -o rivet-plots-MG-VBFNLO-FIXEDMW  -c style_WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/Wm.*OF.*" ../data/minus_CUETP8M1_REBIN_nJets.yoda:$VBFNLOPY ../data/WmZTo1E1Nu2Mu_FixedScaleMW_LHConfig_madgraph-pythia8_REBIN_nJets.yoda:$MGEMMFIXED ../data/WmZTo1E1Nu2Mu_FixedScaleMW_LHConfig_VBFNLO-Herwig7_REBIN_nJets.yoda:$VBFNLOHW ../data/VBS_WZ_MW_Sherpa_REBIN_nJets.yoda:$SHERPA"

# Use binning from old Rivet routine
comm_vbfnlo_herwig="rivet-mkhtml -n5 -o ~/www/Rivet/rivet-plots-MG-VBFNLO-Herwig_all  -c style_WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/Wm.*OF.*" ../data/WmZTo1E1Nu2Mu_FixedScaleMW_LHConfig_OldBinning_madgraph-pythia8.yoda:$MGEMMFIXED ../data/WmZTo1E1Nu2Mu_FixedScaleMW_LHConfig_OldBinning_VBFNLO-Herwig7.yoda:$VBFNLOHW ../data/WmZTo1E1Nu2Mu_FixedScaleMW_LHConfig_fromLHE_VBFNLO-Herwig7.yoda:$VBFNLOHW_SO"

comm_mg_Wm="rivet-mkhtml -n5 -o rivet-plots-MG-Wm -c style_WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/Wm.*OF.*" ../data/WLLJJ_EWK-MGLO_CentralSample.yoda:$MGCENTRAL ../data/WLLJJ_EWK-MGLO_FixedScaleMZ.yoda:$MGFIXEDMZ ../data/WmZTo1E1Nu2Mu_FixedScaleMW_LHConfig_madgraph-pythia8.yoda:$MGEMMFIXED"

#comm_mg_all="rivet-mkhtml -n5 -o rivet-plots-MG-all -c style_WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/.*" ../data/WLLJJ_EWK-MGLO_CentralSample.yoda:$MGCENTRAL ../data/WLLJJ_EWK-MGLO_FixedScaleMZ.yoda:$MGFIXEDMZ" 

comm_dyn="rivet-mkhtml -n5 -o rivet-plots-dyn -c style_WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/Wm.*OF.*" ../data/WZTo1E1Nu2Mu_MAXPTJ_LHConfig_madgraph-pythia8.yoda:$MGEMMMAXPTJ ../data/WmZTo1E1Nu2Mu_FixedScaleMW_LHConfig_madgraph-pythia8.yoda:$MGEMMFIXED ../data/VBS_OF_dyn_Sherpa_100M.yoda:$SHERPA_DYN" 

comm_dyn_rebin="rivet-mkhtml -n5 -o rivet-plots-dyn -c style_WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/Wm.*OF.*" ../data/VBS_WZ_dyn_Sherpa_REBIN_nJets.yoda:$SHERPA_DYN ../data/VBS_WZ_MW_Sherpa_REBIN_nJets.yoda:$SHERPA ../data/WmZTo1E1Nu2Mu_MAXPTJ_LHConfig_madgraph-pythia8_REBIN_nJets.yoda:$MGEMMMAXPTJ ../data/WmZTo1E1Nu2Mu_FixedScaleMW_LHConfig_madgraph-pythia8_REBIN_nJets.yoda:$MGEMMFIXED" 

#comm_vbfnlo_tune="rivet-mkhtml -n5 -o rivet-plots-VBFNLO-OF-tune -c style_WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/.*OF.*" ../data/WZTo1E1Nu2Mu_FixedScaleMW_LHConfig_VBFNLO-Pythia8.yoda:$VBFNLOPY ../data/vbs_CUETP8M1.yoda:$VBFNLOPYCUET"

#eval $comm_fixMW

eval $comm_fixMW_rebin

#eval $comm_mg_Wm

#eval $comm_mg_all

#eval $comm_dyn

eval $comm_dyn_rebin

#eval $comm_vbfnlo_tune


