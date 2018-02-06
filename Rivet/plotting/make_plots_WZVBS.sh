#!/bin/sh
# add 
MGCENTRAL="'Title={MadGraph_aMC@NLO}:LineColor=red:ErrorBandColor=red:ErrorBands=1:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
MGEMMFIXED="'Scale=1000:Title={MadGraph_aMC@NLO $\mu=M_W$}:LineColor=green:ErrorBandColor=green:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
VBFNLOPY="'Scale=1000:Title={VBFNLO+PYTHIA $\mu=M_W$}:LineColor=blue:ErrorBandColor=blue:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
VBFNLOHW="'Scale=1000:Title={VBFNLO+HERWIG $\mu=M_W$}:LineColor=magenta:ErrorBandColor=magenta:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
MGFIXEDMZ="'Scale=0.431:Title={MadGraph_aMC@NLO $\mu=M_Z$}:LineColor=teal:ErrorBandColor=teal:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'" # Scale = 7.595/17.63
# use the ones below instead to set also the line color 
#MGCENTRAL="'Title={MadGraph_aMC@NLO}:ErrorBands=1:ErrorBandColor=magenta:LineColor=magenta:ErrorBandOpacity=0.1:LineWidth=0.02'"
#MGFIXEDMZ="'Scale=1.0:Title={MadGraph_aMC@NLO fixed $\mu=m_Z$}:ErrorBands=1:ErrorBandColor=teal:LineColor=teal:ErrorBandOpacity=0.1:LineWidth=0.02'"

# filter the plots with the option -m 
comm_vbfnlo="rivet-mkhtml -n5 -o rivet-plots-MG-VBFNLO-FIXEDMW  -c style_WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/Wm.*OF.*" ../data/WZTo1E1Nu2Mu_FixedScaleMW_LHConfig_VBFNLO-Pythia8.yoda:$VBFNLOPY ../data/WZTo1E1Nu2Mu_FixedScaleMW_LHConfig_madgraph-pythia8.yoda:$MGEMMFIXED ../data/WmZTo1E1Nu2Mu_FixedScaleMW_LHConfig_VBFNLO-Herwig7.yoda:$VBFNLOHW"

comm_mg_Wm="rivet-mkhtml -n5 -o rivet-plots-MG-Wm -c style_WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/Wm.*OF.*" ../data/WLLJJ_EWK-MGLO_CentralSample.yoda:$MGCENTRAL ../data/WLLJJ_EWK-MGLO_FixedScaleMZ.yoda:$MGFIXEDMZ ../data/WZTo1E1Nu2Mu_FixedScaleMW_LHConfig_madgraph-pythia8.yoda:$MGEMMFIXED"

comm_mg_all="rivet-mkhtml -n5 -o rivet-plots-MG-all -c style_WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/.*" ../data/WLLJJ_EWK-MGLO_CentralSample.yoda:$MGCENTRAL ../data/WLLJJ_EWK-MGLO_FixedScaleMZ.yoda:$MGFIXEDMZ"

eval $comm_vbfnlo

eval $comm_mg_Wm

eval $comm_mg_all
