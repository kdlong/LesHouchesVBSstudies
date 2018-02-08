#!/bin/sh
# add 
MGCENTRAL="'Title={MG5_aMC}:LineColor=red:ErrorBandColor=red:ErrorBands=1:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
MGEMMFIXED="'Scale=1000:Title={MG5_aMC $\mu=M_W$}:LineColor=green:ErrorBandColor=green:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
VBFNLOPY="'Scale=1000:Title={VBFNLO+Pythia8 $\mu=M_W$}:LineColor=blue:ErrorBandColor=blue:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
VBFNLOHW="'Scale=1000:Title={VBFNLO+Herwig7 $\mu=M_W$}:LineColor=magenta:ErrorBandColor=magenta:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
VBFNLOPYCUET="'Scale=1000:Title={VBFNLO+Pythia8 $\mu=M_W$ tune CUET}:LineColor=cyan:ErrorBandColor=cyan:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
SHERPA="'Scale=1000:Title={Sherpa}:LineColor=orange:ErrorBandColor=orange:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
MGFIXEDMZ="'Scale=0.431:Title={MG5_aMC $\mu=M_Z$}:LineColor=teal:ErrorBandColor=teal:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'" # Scale = 7.595/17.63
# use the ones below instead to set also the line color 
#MGCENTRAL="'Title={MadGraph_aMC@NLO}:ErrorBands=1:ErrorBandColor=magenta:LineColor=magenta:ErrorBandOpacity=0.1:LineWidth=0.02'"
#MGFIXEDMZ="'Scale=1.0:Title={MadGraph_aMC@NLO fixed $\mu=m_Z$}:ErrorBands=1:ErrorBandColor=teal:LineColor=teal:ErrorBandOpacity=0.1:LineWidth=0.02'"

# filter the plots with the option -m 
comm_vbfnlo="rivet-mkhtml -n5 -o rivet-plots-MG-VBFNLO-FIXEDMW  -c style_WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/Wm.*OF.*" ../data/WZTo1E1Nu2Mu_FixedScaleMW_LHConfig_VBFNLO-Pythia8.yoda:$VBFNLOPY ../data/WZTo1E1Nu2Mu_FixedScaleMW_LHConfig_madgraph-pythia8.yoda:$MGEMMFIXED ../data/WmZTo1E1Nu2Mu_FixedScaleMW_LHConfig_VBFNLO-Herwig7.yoda:$VBFNLOHW"

comm_mg_Wm="rivet-mkhtml -n5 -o rivet-plots-MG-Wm -c style_WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/Wm.*OF.*" ../data/WLLJJ_EWK-MGLO_CentralSample.yoda:$MGCENTRAL ../data/WLLJJ_EWK-MGLO_FixedScaleMZ.yoda:$MGFIXEDMZ ../data/WZTo1E1Nu2Mu_FixedScaleMW_LHConfig_madgraph-pythia8.yoda:$MGEMMFIXED"

comm_mg_all="rivet-mkhtml -n5 -o rivet-plots-MG-all -c style_WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/.*" ../data/WLLJJ_EWK-MGLO_CentralSample.yoda:$MGCENTRAL ../data/WLLJJ_EWK-MGLO_FixedScaleMZ.yoda:$MGFIXEDMZ" 

comm_OF="rivet-mkhtml -n5 -o rivet-plots-OF -c style_WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/.*OF.*" ../data/WLLJJ_EWK-MGLO_CentralSample.yoda:$MGCENTRAL ../data/WLLJJ_EWK-MGLO_FixedScaleMZ.yoda:$MGFIXEDMZ ../data/WZTo1E1Nu2Mu_FixedScaleMW_LHConfig_VBFNLO-Pythia8.yoda:$VBFNLOPY ../data/VBS_OF_dyn_Sherpa_100M.yoda:$SHERPA" 

comm_vbfnlo_tune="rivet-mkhtml -n5 -o rivet-plots-VBFNLO-OF-tune -c style_WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/.*OF.*" ../data/WZTo1E1Nu2Mu_FixedScaleMW_LHConfig_VBFNLO-Pythia8.yoda:$VBFNLOPY ../data/vbs_CUETP8M1.yoda:$VBFNLOPYCUET"

eval $comm_vbfnlo

#eval $comm_mg_Wm

#eval $comm_mg_all

#eval $comm_OF

#eval $comm_vbfnlo_tune


