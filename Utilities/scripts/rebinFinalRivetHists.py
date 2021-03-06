# coding: utf-8
from subprocess import call
import yoda
data_path = "../../Rivet/data"

# WmZ files with fixed scale M_{W} and dynamic scale maxptj
filenames = [
    "WmZTo1E1Nu2Mu_FixedScaleMW_LHConfig_madgraph-pythia8.yoda",
    "VBS_WZ_MW_Sherpa.yoda",
    "minus_CUETP8M1.yoda",
    "WmZTo1E1Nu2Mu_FixedScaleMW_LHConfig_ShowerFix_VBFNLO-Herwig7.yoda",
    "VBS_WZ_dyn_Sherpa.yoda",
    "WmZTo1E1Nu2Mu_MAXPTJ_LHConfig_madgraph-pythia8.yoda"
]
    #"WmZTo1E1Nu2Mu_FixedScaleMW_LHConfig_VBFNLO-Pythia8.yoda",
binning = {
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
        if not type(hist) is yoda.Histo1D:
            continue
        key = name.split("_")[-1] 
        if key not in binning.keys():
            continue
        hist.rebin(*binning[key])
    yoda.write(hists, fullname.replace(".yoda", "_REBIN.yoda"))
    call(["./rebin_nJets.sh",fullname.replace(".yoda", "_REBIN")])
