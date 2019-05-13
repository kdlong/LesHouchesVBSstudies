#!/bin/sh
MGEWWZ_CMS="'Title={MG5_aMC+Py8 LO (CMS)}:LineColor=blue:ErrorBandColor=blue:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
MGEWWZ_CMS_PATH="../data/WZJJ_EW_CMSMGSample_LooseFiducial_REBIN.yoda"
MGEWWZ="'Title={MG5_aMC+Py8 LO}:LineColor=red:ErrorBandColor=red:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
MGEWWZ_PATH="../data/WZJJ_EW_MG_LHConfig_MaxPtJScale_REBIN.yoda"
EWWZ_POWHEG="'Title={Powheg NLO}:LineColor=green:ErrorBandColor=green:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
EWWZ_POWHEG_PATH="../data/WZJJ_EW_LHConfig_powheg-pythia8_LooseFiducial_REBIN.yoda"
#EWWZ_POWHEG_PATH="../data/WZJJ_EW_powheg-pythia8_LooseFiducial_REBIN.yoda"
MGEWWZ_ATLAS="'Title={MG5_aMC+Py8 LO (ATLAS)}:LineColor=red:ErrorBandColor=red:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
#MGEWWZ_ATLAS="'Title={MG5_aMC+Py8 LO (ATLAS)}:LineColor=red:ErrorBandColor=red:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02:Scale=16.33'"
MGEWWZ_ATLAS_PATH="../data/EWWZ_ATLAS_MGPy8_full_REBIN.yoda"
#SherpaEWWZ_ATLAS="'Title={Sherpa LO (ATLAS)}:LineColor=gray:ErrorBandColor=gray:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02:Scale=47.066'"
SherpaEWWZ_ATLAS="'Title={Sherpa LO (ATLAS)}:LineColor=gray:ErrorBandColor=gray:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
SherpaEWWZ_ATLAS_PATH="../data/EWWZ_ATLAS_Sherpa_REBIN.yoda"

MGEWWZ_ATLAS_withZbj="'Title={MG5_aMC+Py8 LO w/Zbj (ATLAS)}:LineColor=green:ErrorBandColor=green:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
MGEWWZ_ATLAS_withZbj_PATH="../data/EWWZ_ATLAS_MGPy8EG_withZbj.yoda"
MGEWWZ_ATLAS_noZbj="'Title={MG5_aMC+Py8 LO no Zbj (ATLAS)}:LineColor=gray:ErrorBandColor=gray:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
MGEWWZ_ATLAS_noZbj_PATH="../data/EWWZ_ATLAS_MGPy8EG_all.yoda"

QCDWZ_MGLO_CMS="'Title={MG5_aMC+Py8 0-3j@LO (CMS)}:LineColor=green:ErrorBandColor=green:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
QCDWZ_MGLO_CMS_PATH="../data/WZTo3LNu_CMS_MGLO_pythia8_REBIN.yoda"
QCDWZ_MGNLO_CMS="'Title={MG5_aMC+Py8 0,1j@NLO (CMS)}:LineColor=blue:ErrorBandColor=blue:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
QCDWZ_MGNLO_CMS_PATH="../data/WZTo3LNu_MGNLO01j_CMS_pythia8_REBIN.yoda"
QCDWZ_powheg_CMS="'Title={POWHEG+Py8 NLO (CMS)}:LineColor=pink:ErrorBandColor=pink:ErrorBands=1:ErrorBandOpacity=0.3:LineWidth=0.02'"
QCDWZ_powheg_PATH="../data/WZTo3LNu_CMS_powheg_pythia8_REBIN.yoda"

comm_ewwz_LH_loose="rivet-mkhtml -n5 -o rivet_WZEW_CMS_tuned -c style_WZVBS_LesHouchesStudy.plot $MGEWWZ_CMS_PATH:Scale=0.5:$MGEWWZ_CMS $MGEWWZ_PATH:$MGEWWZ -m ".*/WZVBS_LesHouchesStudy/WmZ.*OF.*""
comm_ewwz_cms_loose="rivet-mkhtml -n5 -o rivet_WZEW_CMSLH_tuned -c style_WZVBS_LesHouchesStudy.plot $MGEWWZ_CMS_PATH:Scale=0.5:$MGEWWZ_CMS $EWWZ_POWHEG_PATH:$EWWZ_POWHEG -m ".*/WZVBS_LesHouchesStudy/WpZ.*OF.*""
comm_ewwz_cmsmg_loose="rivet-mkhtml -n5 -o rivet_WZEW_MG_CMS -c style_WZVBS_LesHouchesStudy.plot $MGEWWZ_CMS_PATH:$MGEWWZ_CMS" 
comm_ewwz_pwhg_loose="rivet-mkhtml -n5 -o rivet_WZEW_POWHEG -c style_WZVBS_LesHouchesStudy.plot $EWWZ_POWHEG_PATH:$EWWZ_POWHEG"
comm_ewwz_pwhgLH_loose="rivet-mkhtml -n5 -o rivet_WZEW_CMSScaled_tuned -c style_WZVBS_LesHouchesStudy.plot $MGEWWZ_CMS_PATH:Scale=0.45:$MGEWWZ_CMS $EWWZ_POWHEG_PATH:$EWWZ_POWHEG -m ".*/WZVBS_LesHouchesStudy/WpZ.*OF.*""
#comm_ewwz_cms_atlas_all_loose="rivet-mkhtml -n5 -o rivet_WZEW_CMS_ATLAS_loose -c style_WZVBS_LesHouchesStudy.plot $MGEWWZ_CMS_PATH:$MGEWWZ_CMS $MGEWWZ_ATLAS_PATH:$MGEWWZ_ATLAS $SherpaEWWZ_ATLAS_PATH:$SherpaEWWZ_ATLAS"
comm_ewwz_cms_atlas_all_loose="rivet-mkhtml -n5 -o rivet_WZEW_CMS_ATLAS_loose -c style_WZVBS_LesHouchesStudy.plot $MGEWWZ_CMS_PATH:$MGEWWZ_CMS"
comm_ewwz_atlas_loose="rivet-mkhtml -n5 -o rivet_WZEW_ATLAS_loose_unscaled -c style_WZVBS_LesHouchesStudy.plot $MGEWWZ_ATLAS_PATH:$MGEWWZ_ATLAS $SherpaEWWZ_ATLAS_PATH:$SherpaEWWZ_ATLAS"
comm_ewwz_atlas_Zbj="rivet-mkhtml -n5 -o rivet_WZEW_ATLAS_loose_CompareZbj -c style_WZVBS_LesHouchesStudy.plot $MGEWWZ_ATLAS_withZbj_PATH:$MGEWWZ_ATLAS_withZbj $MGEWWZ_ATLAS_noZbj_PATH:$MGEWWZ_ATLAS_noZbj"

comm_qcdwz_cms_atlas_loose="rivet-mkhtml -n5 -o rivet_WZQCD_CMS_ATLAS_loose_ScaleATLASx100 -c style_WZVBS_LesHouchesStudy.plot $QCDWZ_MGLO_CMS_PATH:$QCDWZ_MGLO_CMS $QCDWZ_Sherpa_ATLAS_PATH:$QCDWZ_Sherpa_ATLAS":Scale=100
comm_qcdwz_loose="rivet-mkhtml -n5 -o rivet_WZQCD_CMS -c style_WZVBS_LesHouchesStudy.plot $QCDWZ_MGLO_CMS_PATH:$QCDWZ_MGLO_CMS $QCDWZ_MGNLO_CMS_PATH:$QCDWZ_MGNLO_CMS $QCDWZ_powheg_PATH:$QCDWZ_powheg_CMS" 
comm_qcdwz_loose_scaledinc="rivet-mkhtml -n5 -o rivet_WZQCD_CMS_scaledInc -c style_WZVBS_LesHouchesStudy.plot $QCDWZ_MGLO_CMS_PATH:$QCDWZ_MGLO_CMS $QCDWZ_MGNLO_CMS_PATH:Scale=1000:$QCDWZ_MGNLO_CMS $QCDWZ_powheg_PATH:Scale=1000:$QCDWZ_powheg_CMS" 
comm_qcdwz_loose_scaledCR="rivet-mkhtml -n5 -o rivet_WZQCD_CMS_scaledCR -c style_WZVBS_LesHouchesStudy.plot $QCDWZ_MGLO_CMS_PATH:$QCDWZ_MGLO_CMS $QCDWZ_MGNLO_CMS_PATH:Scale=799:$QCDWZ_MGNLO_CMS $QCDWZ_powheg_PATH:Scale=1124:$QCDWZ_powheg_CMS" 
comm_qcdwz_loose_scaled2j="rivet-mkhtml -n5 -o rivet_WZQCD_CMS_scaled2Jets -c style_WZVBS_LesHouchesStudy.plot $QCDWZ_MGLO_CMS_PATH:$QCDWZ_MGLO_CMS $QCDWZ_MGNLO_CMS_PATH:Scale=789:$QCDWZ_MGNLO_CMS $QCDWZ_powheg_PATH:Scale=1059:$QCDWZ_powheg_CMS" 

#eval $comm_qcdwz_loose
#eval $comm_qcdwz_loose_scaledCR
#eval $comm_qcdwz_loose_scaled2j

#eval $comm_ewwz_LH_loose
#eval $comm_ewwz_pwhgLH_loose
#eval $comm_ewwz_cmsmg_loose
#eval $comm_ewwz_cms_loose
#eval $comm_ewwz_pwhg_loose
#eval $comm_ewwz_cms_atlas_all_loose
#eval $comm_ewwz_atlas_loose
#eval $comm_ewwz_atlas_Zbj
eval $comm_ewwz_atlas_loose
#eval $comm_qcdwz_cms_atlas_loose
