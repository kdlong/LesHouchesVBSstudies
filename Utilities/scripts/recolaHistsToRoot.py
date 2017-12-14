import ROOT
import array
import glob

ROOT.gROOT.SetBatch(True)

def makeRecolaHist(hist_file_name):
    data = readMATRIXHistData(hist_file_name)

    central_hist_name = hist_file_name.split("/")[-1].replace(".dat", "")
    nbins = len(data)-1
    varbins = array.array('f', [x[1] for x in data]+[data[-1][2]])
    central_hist = ROOT.TH1D(central_hist_name, central_hist_name, nbins, varbins)

    for i, entry in enumerate(data):
        central_hist.SetBinContent(i+1, entry[3])
        central_hist.SetBinError(i+1, entry[4])
    
    return central_hist

def readMATRIXHistData(hist_file_name):
    data = []
    with open(hist_file_name) as hist_file:
        for line in hist_file:
            entry = line.split("#")[0]
            entry_data = [float(i) for i in entry.split()]
            if not entry_data:
                continue
            data.append(entry_data)
    if len(data[0]) != 6:
        raise(ValueError, "Invalid input. Expected input to have 7 values per entry")
    return data

canvas = ROOT.TCanvas("canvas", "canvas")

hist_file_path = "histogram_invariant_mass_mjj12_born_alpha6.dat"
output_path = "." 

for hist_file in glob.glob(hist_file_path):
    central = makeRecolaHist(hist_file)
    central.SetMarkerSize(0)
    central.SetMinimum(central.GetMinimum()*.9)
    central.SetMaximum(central.GetMaximum()*1.1)
    central.Draw("hist e1")
    output_name = hist_file.split("/")[-1].replace(".dat","")
    canvas.Print(output_path + "/%s.pdf" % output_name)
    canvas.Print(output_path + "/%s.root" % output_name)
