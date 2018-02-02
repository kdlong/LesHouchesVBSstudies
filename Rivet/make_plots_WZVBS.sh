#!/bin/sh
# add 
MGCENTRAL="'Title={MadGraph_aMC@NLO}:ErrorBands=1:ErrorBandOpacity=0.1:LineWidth=0.02'"
MGFIXEDMZ="'Scale=0.33:Title={MadGraph_aMC@NLO fixed $\mu=m_Z$}:ErrorBands=1:ErrorBandColor=orange:ErrorBandOpacity=0.1:LineWidth=0.02'"
# use the ones below instead to set also the line color 
#MGCENTRAL="'Title={MadGraph_aMC@NLO}:ErrorBands=1:ErrorBandColor=magenta:LineColor=magenta:ErrorBandOpacity=0.1:LineWidth=0.02'"
#MGFIXEDMZ="'Scale=1.0:Title={MadGraph_aMC@NLO fixed $\mu=m_Z$}:ErrorBands=1:ErrorBandColor=teal:LineColor=teal:ErrorBandOpacity=0.1:LineWidth=0.02'"

# filter the plots with the option -m 
comm="rivet-mkhtml -n5 -c WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/.*" wzjj_ewk_central.yoda:$MGCENTRAL wzjj_ewk_fixed.yoda:$MGFIXEDMZ"

eval $comm
