/*
 * WZVBS_LesHouchesStudy.cc
 *
 *  Created on: Dec. 8, 2017
 *      Author: Les Houches MC working group
 */

// -*- C++ -*-
#include "Rivet/Analysis.hh"
#include "Rivet/Projections/FinalState.hh"
#include "Rivet/Projections/LeadingParticlesFinalState.hh"
#include "Rivet/Projections/ChargedLeptons.hh"
#include "Rivet/Projections/DressedLeptons.hh"
#include "Rivet/Projections/PromptFinalState.hh"
#include "Rivet/Projections/VisibleFinalState.hh"
#include "Rivet/Projections/FastJets.hh"

#include <iostream>
#include <algorithm>
#include <string> 

static const float ZMASS = 91.1876;

namespace Rivet {

class WZVBS_LesHouchesStudy: public Analysis {
public:
    float totalEvents = 0;
    float sumSelectedWeights = 0;
    float sumWeightsLeps = 0;
    float sumWeights2j = 0;
    float sumWeightsZ = 0;
    float sumWeightsVeto = 0;
    float selectedEvents = 0;

    WZVBS_LesHouchesStudy() : Analysis("WZVBS_LesHouchesStudy"){};

    void init() {
        double lepConeSize = 0.1;
        double lepMaxEta = 2.5;
  
        Cut lepton_cut   = (Cuts::abseta < lepMaxEta);
  
        // Initialise and register projections
        FinalState fs(-2.5,2.5,0.0*GeV);
        FinalState fsm(-5,5,0.0*GeV);
        addProjection(fs, "FS");
        addProjection(fsm, "FSM");
  
        ChargedLeptons charged_leptons(fs);
        IdentifiedFinalState photons(fs);
        photons.acceptIdPair(PID::PHOTON);
  
        PromptFinalState prompt_leptons(charged_leptons);
        prompt_leptons.acceptMuonDecays(true);
        prompt_leptons.acceptTauDecays(false);
  
        PromptFinalState prompt_photons(photons);
        prompt_photons.acceptMuonDecays(true);
        prompt_photons.acceptTauDecays(false);
  
        DressedLeptons dressed_leptons = DressedLeptons(prompt_photons, prompt_leptons, lepConeSize, lepton_cut, /*cluster*/ true, /*useDecayPhotons*/ true);
        addProjection(dressed_leptons, "DressedLeptons");

        addProjection(FastJets(FinalState(-4.7, 4.7), FastJets::ANTIKT, 0.4),"jets");

        bookChannelHist("Zlep1_Pt", 20, 0, 200);
        bookChannelHist("Zlep1_Eta", 20, -2.5, 2.5);
        bookChannelHist("Zlep2_Pt", 20, 0, 120);
        bookChannelHist("Zlep2_Eta", 20, -2.5, 2.5);
        bookChannelHist("Wlep_Pt", 20, 0, 150);
        bookChannelHist("Wlep_Eta", 20, -2.5, 2.5);

        // Composite variables
        bookChannelHist("Mass3l", 40, 0, 400);
        bookChannelHist("Pt3l", 30, 0, 300);
        bookChannelHist("ZMass", 32, 75, 107);
        bookChannelHist("ZPt", 30, 0, 300);
        bookChannelHist("ZEta", 20, -3, 3);
        
        // VBS variables
        bookChannelHist("mjj", 100, 0, 2000);
        bookChannelHist("dEtajj", 16, 0, 8);
        bookChannelHist("zep3l", 10, 0, 5);
    }

    void analyze(const Event& event) {
        double weight = event.weight();
        totalEvents++;
    
        Particles leptons = applyProjection<DressedLeptons>(event, "DressedLeptons").particlesByPt(20*GeV);

        if (leptons.size() < 3) {
            vetoEvent;
        }
        sumWeightsLeps += weight;

        if (leptons.size() != 3) {
            vetoEvent;
        }
        sumWeightsVeto += weight;

        int sumPids = leptons.at(0).pdgId()+leptons.at(1).pdgId()+leptons.at(2).pdgId();
        int sumAbsPids = std::abs(leptons.at(0).pdgId())+std::abs(leptons.at(1).pdgId())+std::abs(leptons.at(2).pdgId());

        // Unique identifier = sum(abs(pdgid)) * 1 if W-, -1 if W+
        int chanId = (sumPids > 0) ? sumAbsPids : -1*sumAbsPids;

        if (std::abs(sumPids) != 11 && std::abs(sumPids) != 13) {
            vetoEvent;
            std::cerr << "WARNING: Found expected event without sum(pdgID) = " 
                      << sumPids << std::endl;
        }

        bool sameFlavorState = (leptons.at(0).pdgId() == leptons.at(1).pdgId()) ||
                    (leptons.at(0).pdgId() == leptons.at(2).pdgId()) ||
                    (leptons.at(1).pdgId() == leptons.at(2).pdgId());
        // Sort as Leading Z lep, subleading Z lep, W lep
        if (!sameFlavorState) {
            // Leps 1 and 3 is best combo
            if ((leptons.at(0).pdgId() + leptons.at(2).pdgId()) == 0) {
                std::iter_swap(leptons.begin()+1,leptons.begin()+2);
            }
            // Leps 2 and 3 is best combo
            else if ((leptons.at(1).pdgId() + leptons.at(2).pdgId()) == 0) {
                std::iter_swap(leptons.begin(),leptons.begin()+2);
                std::iter_swap(leptons.begin(),leptons.begin()+1);
            }
        }
        else {
            // Find best Z candidate, then reorder leptons appropriately
            std::vector<float> zCandMasses;
            auto getCompositeMass= [](Particle lep1, Particle lep2) {
                if ((lep1.pdgId() + lep2.pdgId()) == 0)
                    return (lep1.momentum() + lep2.momentum()).mass();
                else
                    return 10000.0;
            };

            zCandMasses.push_back(std::abs(getCompositeMass(leptons.at(0), leptons.at(1))-ZMASS));
            zCandMasses.push_back(std::abs(getCompositeMass(leptons.at(0), leptons.at(2))-ZMASS));
            zCandMasses.push_back(std::abs(getCompositeMass(leptons.at(1), leptons.at(2))-ZMASS));

            int min_index = std::distance(zCandMasses.begin(), 
                    min_element(zCandMasses.begin(), zCandMasses.end()));

            // Leps 1 and 3 is best combo
            if (min_index == 1) {
                std::iter_swap(leptons.begin()+1,leptons.begin()+2);
            }
            // Leps 2 and 3 is best combo
            else if (min_index == 2) {
                std::iter_swap(leptons.begin(),leptons.begin()+2);
                std::iter_swap(leptons.begin(),leptons.begin()+1);
            }
        }

        FourMomentum bestZCand = leptons.at(0).momentum() + leptons.at(1).momentum();
        FourMomentum leptonSystem = leptons.at(2).momentum() + bestZCand;

        if (std::abs(bestZCand.mass() - ZMASS) > 15)
            vetoEvent;
        sumWeightsZ += weight;

        Jets jets;
        foreach (const Jet& jet, applyProjection<FastJets>(event, "jets").jetsByPt(30.0*GeV) ) {
        bool isolated = true;
        foreach (const Particle& lepton, leptons) {
            if (deltaR(lepton, jet) < 0.4) {
                isolated = false;
                break;
            }
        }
        if (isolated)
            jets.push_back(jet);
        }

        if (jets.size() < 2) {  
            vetoEvent;
        }
     
        FourMomentum dijet_system = jets.at(0).momentum() + jets.at(1).momentum();
        
        float mjj = dijet_system.mass();
        float dEtajj = std::abs(jets.at(0).momentum().eta() - jets.at(1).momentum().eta());
        float zep3l = leptonSystem.eta() - 0.5*(jets.at(0).momentum().eta()  + jets.at(1).momentum().eta());
        sumWeights2j += weight;

        if (mjj < 500 || dEtajj < 2.5)
            vetoEvent;

        sumSelectedWeights += weight;
        selectedEvents++;

        // Primitive variables
        channelHists_["Zlep1_Pt"].fill(leptons.at(0).pt(), weight, chanId);
        channelHists_["Zlep1_Eta"].fill(leptons.at(0).eta(), weight, chanId);
        channelHists_["Zlep2_Pt"].fill(leptons.at(1).pt(), weight, chanId);
        channelHists_["Zlep2_Eta"].fill(leptons.at(1).eta(), weight, chanId);
        channelHists_["Wlep_Pt"].fill(leptons.at(2).pt(), weight, chanId);
        channelHists_["Wlep_Eta"].fill(leptons.at(2).eta(), weight, chanId);

        // Composite variables
        channelHists_["Mass3l"].fill(leptonSystem.mass(), weight, chanId);
        channelHists_["Pt3l"].fill(leptonSystem.pt(), weight, chanId);
        channelHists_["ZMass"].fill(bestZCand.mass(), weight, chanId);
        channelHists_["ZPt"].fill(bestZCand.pt(), weight, chanId);
        channelHists_["ZEta"].fill(bestZCand.eta(), weight, chanId);
        
        // VBS variables
        channelHists_["mjj"].fill(mjj, weight, chanId);
        channelHists_["dEtajj"].fill(dEtajj, weight, chanId);
        channelHists_["zep3l"].fill(zep3l, weight, chanId);
    }

    void finalize() {
        std::cout << "Finalizing..." << endl;  

        float efficiency= selectedEvents/totalEvents; 
        double xsec = crossSection();

        std::cout << "SumOfWeights() processed = " << sumOfWeights() << endl;
        std::cout << "Selected sumWeights = " << sumSelectedWeights << endl;
        std::cout << "Sum weights passing lepton selection = " << sumWeightsLeps << endl;
        std::cout << "    cross section = " << sumWeightsLeps*xsec/sumOfWeights() << endl;
        std::cout << "Sum weights passing lepton veto = " << sumWeightsVeto << endl;
        std::cout << "    cross section = " << sumWeightsVeto*xsec/sumOfWeights() << endl;
        std::cout << "Sum weights passing Z selection = " << sumWeightsZ << endl;
        std::cout << "    cross section = " << sumWeightsZ*xsec/sumOfWeights() << endl;
        std::cout << "Sum weights passing 2j selection = " << sumWeights2j << endl;
        std::cout << "    cross section = " << sumWeights2j*xsec/sumOfWeights() << endl;
        std::cout << std::endl << "Selected Events = " << selectedEvents << ", Total= " << totalEvents << endl;
        std::cout << "Efficiency = " << efficiency << endl;    
        
        std::cout << "Initial cross section was: " << xsec << std::endl;
        std::cout << "Fiducial cross section is: " << xsec*sumSelectedWeights/sumOfWeights() << std::endl;
        
        for (const auto& hist : hists1D_)
            scale(hist.second, xsec / sumOfWeights());
        for (auto& chanHist : channelHists_) {
            chanHist.second.Scale(xsec, sumOfWeights());
        }
    }        

private:
    // Label = sum{abs(pdgid)}*sign(sum{pdgid})
    // For now we don't distiguish between e/m states
    std::map <int, std::string> channels_ = {
        { 35 , "WpZ_OF"},
        { 37 , "WpZ_OF"},
        { 33 , "WpZ_SF"},
        { 39 , "WpZ_SF"},
        { -35 , "WmZ_OF"},
        { -37 , "WmZ_OF"},
        { -33 , "WmZ_SF"},
        { -39 , "WmZ_SF"}
    };
    class ByChannelHist {
        private:
            // Needed to access functions in Analysis (e.g. Analysis::scale)
            Analysis* analysis_;
            std::map<int, Histo1DPtr> hists_;

        public:
            ByChannelHist() : analysis_(NULL) {};
            ByChannelHist(Analysis* analysis) : analysis_(analysis) {};

            void SetHist(Histo1DPtr hist, int channel) {
                hists_[channel] = hist;
            };

            void Scale(double xsec, double sumWeights) {
                for (const auto& hist : hists_) {
                    analysis_->scale(hist.second, xsec / sumWeights);
                }
            };

            void fill(double value, double weight, int channel) {
                if (hists_.find(channel) == hists_.end()) {
                    throw std::runtime_error("Attempt to fill hist for invalid channel");
                }

                hists_[channel]->fill(value, weight);
                if (channel != 0)
                    hists_[0]->fill(value, weight);
            };
    };
    std::map<std::string, Histo1DPtr> hists1D_;
    std::map<std::string, ByChannelHist> channelHists_;

    void bookChannelHist (const std::string histname, int bins, float binlow, float binhigh) {
        channelHists_[histname] = ByChannelHist(this);
        // Central hist
        channelHists_[histname].SetHist(bookHisto1D(histname, bins, binlow, binhigh), 0);

        for (auto& channel : channels_) {
            const std::string chanHistName = histname + "_" + channel.second;
            channelHists_[histname].SetHist(bookHisto1D(chanHistName, bins, binlow, binhigh), channel.first);
        }
    };
};

DECLARE_RIVET_PLUGIN (WZVBS_LesHouchesStudy);
}
