#!/bin/sh
# add 
MGCENTRAL="'Title={MadGraph_aMC@NLO}:ErrorBands=1:ErrorBandOpacity=0.1:LineWidth=0.02'"
MGEMMFIXED="'Scale=1000:Title={MadGraph_aMC@NLO emumu fixed scale}:ErrorBands=1:ErrorBandOpacity=0.1:LineWidth=0.02'"
VBFNLOPY="'Scale=1000:Title={VBFNLO+PYTHIA}:ErrorBands=1:ErrorBandOpacity=0.1:LineWidth=0.02'"
VBFNLOHW="'Scale=1000:Title={VBFNLO+HERWIG Wm}:ErrorBands=1:ErrorBandOpacity=0.1:LineWidth=0.02'"
MGFIXEDMZ="'Scale=0.33:Title={MadGraph_aMC@NLO fixed $\mu=m_Z$}:ErrorBands=1:ErrorBandColor=orange:ErrorBandOpacity=0.1:LineWidth=0.02'"
# use the ones below instead to set also the line color 
#MGCENTRAL="'Title={MadGraph_aMC@NLO}:ErrorBands=1:ErrorBandColor=magenta:LineColor=magenta:ErrorBandOpacity=0.1:LineWidth=0.02'"
#MGFIXEDMZ="'Scale=1.0:Title={MadGraph_aMC@NLO fixed $\mu=m_Z$}:ErrorBands=1:ErrorBandColor=teal:LineColor=teal:ErrorBandOpacity=0.1:LineWidth=0.02'"

# filter the plots with the option -m 
#comm="rivet-mkhtml -n5 -c style_WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/.*" data/WLLJJ_EWK-MGLO_CentralSample.yoda:$MGCENTRAL data/WLLJJ_EWK-MGLO_FixedScaleMZ.yoda:$MGFIXEDMZ data/VBFNLO_PYTHIA8_80M.yoda:$VBFNLOPY"
comm="rivet-mkhtml -n5 -c style_WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/Wm.*" data/WmZTo1E1Nu2Mu_FixedScaleMW_LHConfig_VBFNLO-Herwig7.yoda:$VBFNLOHW data/WZTo1E1Nu2Mu_FixedScaleMW_LHConfig_madgraph-pythia8.yoda:$MGEMMFIXED data/vbs_add.yoda:$VBFNLOPY"

eval $comm
