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

static const float ZMASS = 91.1876;

namespace Rivet {

class WZVBS_LesHouchesStudy: public Analysis {
public:
    float totalEvents=0;
    float selectedEvents=0;


    /// Constructor
    WZVBS_LesHouchesStudy() : Analysis("WZVBS_LesHouchesStudy"){

    }

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

        hists1D_["Zlep1_Pt"] = bookHisto1D("Zlep1_Pt", 20, 0, 200);
        hists1D_["Zlep1_Eta"] = bookHisto1D("Zlep1_Eta", 20, -2.5, 2.5);
        hists1D_["Zlep2_Pt"] = bookHisto1D("Zlep2_Pt", 20, 0, 120);
        hists1D_["Zlep2_Eta"] = bookHisto1D("Zlep2_Eta", 20, -2.5, 2.5);
        hists1D_["Wlep_Pt"] = bookHisto1D("Wlep_Pt", 20, 0, 150);
        hists1D_["Wlep_Eta"] = bookHisto1D("Wlep_Eta", 20, -2.5, 2.5);

        // Composite variables
        hists1D_["Mass3l"] = bookHisto1D("Mass3l", 40, 0, 400);
        hists1D_["Pt3l"] = bookHisto1D("Pt3l", 30, 0, 300);
        hists1D_["ZMass"] = bookHisto1D("ZMass", 32, 75, 107);
        hists1D_["ZPt"] = bookHisto1D("ZPt", 30, 0, 300);
        hists1D_["ZEta"] = bookHisto1D("ZEta", 20, -3, 3);
        
        // VBS variables
        hists1D_["mjj"] = bookHisto1D("mjj", 100, 0, 2000);
        hists1D_["dEtajj"] = bookHisto1D("dEtajj", 16, 0, 8);
        hists1D_["zep3l"] = bookHisto1D("zep3l", 10, 0, 5);
    }

    void analyze(const Event& event) {
        double weight = event.weight();
        totalEvents++;
    
        Particles leptons = applyProjection<DressedLeptons>(event, "DressedLeptons").particlesByPt(10*GeV);

        if (leptons.size() != 3) {
            vetoEvent;
        }

        int sumPids = leptons.at(0).pdgId()+leptons.at(1).pdgId()+leptons.at(2).pdgId();
        if (std::abs(sumPids) != 11 && std::abs(sumPids) != 13) {
            vetoEvent;
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
            //std::cout << "Vetoing for failing Zmass contraint. mll is " << bestZCand.mass() << std::endl;
            vetoEvent;

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
     
        selectedEvents++;
        FourMomentum dijet_system = jets.at(0).momentum() + jets.at(1).momentum();
        
        float mjj = dijet_system.mass();
        float dEtajj = std::abs(jets.at(0).momentum().eta() - jets.at(1).momentum().eta());
        float zep3l = leptonSystem.eta() - 0.5*(jets.at(0).momentum().eta()  + jets.at(1).momentum().eta());

        // Inconveniently reduces events for testing
        if (mjj < 500 || dEtajj < 2.5)
            vetoEvent;

        // Primitive variables
        hists1D_["Zlep1_Pt"]->fill(leptons.at(0).pt(), weight);
        hists1D_["Zlep1_Eta"]->fill(leptons.at(0).eta(), weight);
        hists1D_["Zlep2_Pt"]->fill(leptons.at(1).pt(), weight);
        hists1D_["Zlep2_Eta"]->fill(leptons.at(1).eta(), weight);
        hists1D_["Wlep_Pt"]->fill(leptons.at(2).pt(), weight);
        hists1D_["Wlep_Eta"]->fill(leptons.at(2).eta(), weight);

        // Composite variables
        hists1D_["Mass3l"]->fill(leptonSystem.mass(), weight);
        hists1D_["Pt3l"]->fill(leptonSystem.pt(), weight);
        hists1D_["ZMass"]->fill(bestZCand.mass(), weight);
        hists1D_["ZPt"]->fill(bestZCand.pt(), weight);
        hists1D_["ZEta"]->fill(bestZCand.eta(), weight);
        
        // VBS variables
        hists1D_["mjj"]->fill(mjj, weight);
        hists1D_["dEtajj"]->fill(dEtajj, weight);
        hists1D_["zep3l"]->fill(zep3l, weight);
    }

    void finalize() {
        std::cout << "Finalizing..." << endl;  

        float efficiency= selectedEvents/totalEvents; 
        std::cout << "SumOfWeights() = " << sumOfWeights() << endl;
        std::cout << "efficiency = " << efficiency << endl;    
        std::cout << "selected Events = " << selectedEvents << ", total= " << totalEvents << endl;
        
        double xsec = crossSection();
        std::cout << "xsec is: " << xsec << std::endl;
        
        for (const auto& hist : hists1D_)
            scale(hist.second, xsec / sumOfWeights());
    }        

private:
    std::map<std::string, Histo1DPtr> hists1D_;
};

DECLARE_RIVET_PLUGIN (WZVBS_LesHouchesStudy);
}
