# coding: utf-8
import ROOT
import math
recola_file = ROOT.TFile("histogram_rapidity_separation_j1j2_born.root")
recola_hist = recola_file.Get("canvas").GetListOfPrimitives().FindObject("histogram_rapidity_separation_j1j2_born")
mg_file = ROOT.TFile("/afs/cern.ch/user/k/kelong/work/DibosonMCAnalysis/CMSSW_8_0_30/src/GenNtuplizer/Utilities/PlotingScripts/MGHists/MGPartonPlots-nobquarks-mathieusSetup_wmonly.root")
mg_hist = mg_file.Get("hdeta")
    
new_recola_hist = mg_hist.Clone()
for i in range(mg_hist.GetNbinsX()+1): new_recola_hist.SetBinContent(i,0)

bins = [2.25 + x*0.25 for x in range(0,26)]
for x in bins:
    new_content = recola_hist.GetBinContent(recola_hist.FindBin(x)) + recola_hist.GetBinContent(recola_hist.FindBin(x*-1-0.001))
    new_error = math.sqrt(recola_hist.GetBinError(recola_hist.FindBin(x))**2+recola_hist.GetBinError(recola_hist.FindBin(x*-1-0.001))**2)
    new_recola_hist.SetBinContent(mg_hist.FindBin(x), new_content)
    new_recola_hist.SetBinError(mg_hist.FindBin(x), new_error)
    
outfile = ROOT.TFile("recola_etajj.root", "recreate")
new_recola_hist.Write()
outfile.Close()
