//
//  PitchController.swift
//  PitchController
//
//  Created by Agha Shahriyar on 24/08/2020.
//  Copyright © 2020 AghaIndus. All rights reserved.
//

import UIKit

class PitchController: UIViewController {
    
    @IBOutlet weak var pitchSlider: UISlider!
    @IBOutlet weak var pitchLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var rateSlider: UISlider!
    
    let pitchViewModel = PitchControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pitchViewModel.startPlayer()
        self.pitchDelegates()
        self.rateLbl.text = "1.00x"
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Button Action

    
    @IBAction func pitchValueChanged(_ sender: UISlider) {
        let step : Float = 100.0
        var pitchValue = roundf(sender.value)
        let newStep = roundf(pitchValue/step)
        pitchValue = newStep * step
        pitchViewModel.changePitchValue(pitchValue: pitchValue, rateValue: rateSlider.value)
    }
    
    @IBAction func rateValueChange(_ sender: UISlider) {
        let step: Float = 0.25
        var rate = sender.value
        let newStep = roundf(rate / step)
        rate = newStep * step
        pitchViewModel.changeRateValue(rateValue: rate)
    }
    
    func pitchDelegates()  {
        pitchViewModel.pitchValueChangeClosure = { pitchValue in
            self.pitchLbl.text = String(format: "%i cents", Int(pitchValue))
        }
        
        pitchViewModel.rateValueChangeClosure = { rate in
            self.rateLbl.text = String(format: "%.2fx", rate)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
