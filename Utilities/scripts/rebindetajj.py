# coding: utf-8
import ROOT
import math

isSherpa=False

if isSherpa:
    input_file = ROOT.TFile("../../Rivet/data/Sherpa_FO.root")
    input_hist = input_file.Get("WZVBS_LesHouchesStudy/dEtajj")
    output_name = "Sherpa_FO_etajj.root"
else:
    input_file = ROOT.TFile("histogram_rapidity_separation_j1j2_born.root")
    input_hist = input_file.Get("canvas").GetListOfPrimitives().FindObject("histogram_rapidity_separation_j1j2_born")
    output_name = "recola_etajj.root"

ref_file = ROOT.TFile("/afs/cern.ch/user/k/kelong/work/DibosonMCAnalysis/CMSSW_8_0_30/src/GenNtuplizer/Utilities/PlotingScripts/MGHists/MGPartonPlots-nobquarks-mathieusSetup_wmonly.root")
ref_hist = ref_file.Get("hdeta")
    
new_input_hist = ref_hist.Clone()
for i in range(ref_hist.GetNbinsX()+1): new_input_hist.SetBinContent(i,0)

bins = [2.25 + x*0.25 for x in range(0,23 if isSherpa else 26)]
for x in bins:
    new_content = input_hist.GetBinContent(input_hist.FindBin(x)) + input_hist.GetBinContent(input_hist.FindBin(x*-1-0.001))
    new_error = math.sqrt(input_hist.GetBinError(input_hist.FindBin(x))**2+input_hist.GetBinError(input_hist.FindBin(x*-1-0.001))**2)
    new_input_hist.SetBinContent(ref_hist.FindBin(x), new_content)
    new_input_hist.SetBinError(ref_hist.FindBin(x), new_error)
    
outfile = ROOT.TFile(output_name, "recreate")
new_input_hist.Write()
outfile.Close()
