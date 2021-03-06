MGCENTRAL="'Title={MadGraph_aMC@NLO}:ErrorBands=1:ErrorBandOpacity=0.1:LineWidth=0.02'"
MGEMMFIXED="'Title={MadGraph_aMC@NLO e$\mu\mu$fixed scale}:ErrorBands=1:ErrorBandOpacity=0.1:LineWidth=0.02'"
VBFNLOPY="'Scale=1000:Title={VBFNLO+PYTHIA}:ErrorBands=1:ErrorBandOpacity=0.1:LineWidth=0.02'"
VBFNLOHW="'Title={VBFNLO+HERWIG Wm}:ErrorBands=1:ErrorBandOpacity=0.1:LineWidth=0.02'"
#MGFIXEDMZ="'Scale=0.33:Title={MadGraph_aMC@NLO fixed $\mu=m_Z$}:ErrorBands=1:ErrorBandColor=orange:ErrorBandOpacity=0.1:LineWidth=0.02'"
# use the ones below instead to set also the line color 
#MGCENTRAL="'Title={MadGraph_aMC@NLO}:ErrorBands=1:ErrorBandColor=magenta:LineColor=magenta:ErrorBandOpacity=0.1:LineWidth=0.02'"
#MGFIXEDMZ="'Scale=1.0:Title={MadGraph_aMC@NLO fixed $\mu=m_Z$}:ErrorBands=1:ErrorBandColor=teal:LineColor=teal:ErrorBandOpacity=0.1:LineWidth=0.02'"

# filter the plots with the option -m 
comm="rivet-mkhtml -n5 -c style_WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/.*" data/WZJJ_EW_MadGraphCentralSample_CMSTight_withCR.yoda:$MGCENTRAL -o ~/www/Rivet/CMS_SMP_18_001"
#comm="rivet-mkhtml -n5 -c style_WZVBS_LesHouchesStudy.plot  -m ".*/WZVBS_LesHouchesStudy/Wm.*" data/WmZTo1E1Nu2Mu_FixedScaleMW_LHConfig_VBFNLO-Herwig7.yoda:$VBFNLOHW data/WZTo1E2Mu_FixedScaleMW_LHConfig_madgraph-pythia8.yoda:$MGEMMFIXED"

eval $comm
