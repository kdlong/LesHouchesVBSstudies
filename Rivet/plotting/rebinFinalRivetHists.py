# coding: utf-8
from subprocess import call
import yoda
data_path = "../data"

# WmZ files with fixed scale M_{W} and dynamic scale maxptj
filenames = [
    #"WZTo3LNu_CMS_MGLO_pythia8.yoda",
    #"WZTo3LNu_MGNLO01j_CMS_pythia8.yoda",
    #"WZTo3LNu_CMS_powheg_pythia8.yoda",
    #"EWWZ_ATLAS_MGPy8EG_NNPDF30LO_A14NNPDF23LO_WZlvlljjEWK.v1.yoda",
    #"EWWZ_ATLAS_Sherpa_222_NNPDF30NNLO.v1.yoda",
    "EWWZ_ATLAS_Sherpa.yoda",
    "EWWZ_ATLAS_MGPy8_full.yoda",
    #"WZJJ_EW_MG_LHConfig_MaxPtJScale.yoda"
    #"WZJJ_EW_CMSMGSample_LooseFiducial.yoda",
    #"WZJJ_EW_MG_LHConfig_LooseFiducial.yoda",
    #"WZJJ_EW_LHConfig_powheg-pythia8_LooseFiducial.yoda",
]
    #"WmZTo1E1Nu2Mu_FixedScaleMW_LHConfig_VBFNLO-Pythia8.yoda",
binning = {
    "Mass3l" : [4],
    "dEtajj" : [2],
    "mjj" : [5],
    "zep3l" : [2],
    "zepj3" : [2],
    "dRjj" : [2],
}


for filename in filenames:
    fullname = "/".join([data_path, filename])
    hists = yoda.read(fullname)
    for name, hist in hists.iteritems():
        name = name.split("/")[-1]
        if not type(hist) is yoda.Histo1D:
            continue
        key = name.split("_")[-1] 
        if key not in binning.keys():
            continue
        hist.rebin(*binning[key])
    yoda.write(hists, fullname.replace(".yoda", "_REBIN.yoda"))
