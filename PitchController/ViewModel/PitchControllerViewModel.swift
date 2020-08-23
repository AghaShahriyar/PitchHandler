//
//  PitchControllerViewModel.swift
//  PitchController
//
//  Created by Agha Shahriyar on 24/08/2020.
//  Copyright © 2020 AghaIndus. All rights reserved.
//

import Foundation
import AVFoundation

class PitchControllerViewModel {
    
    var pitchValueChangeClosure: ((_ pitchValue:Float) -> ())?
    var rateValueChangeClosure: ((_ rate:Float) -> ())?

    
    var isPitchValueChanged:Bool = false {
        didSet {
            self.pitchValueChangeClosure?(pitch.pitch)
        }
    }
    
    var isRateValueChanged:Bool = false {
        didSet {
            self.rateValueChangeClosure?(pitch.rate)
        }
    }
    
    var engine: AVAudioEngine!
    var player: AVAudioPlayerNode!
    var file = AVAudioFile()
    let pitch = AVAudioUnitTimePitch()
    
    init() {
        engine = AVAudioEngine()
        player = AVAudioPlayerNode()
        player.volume = AudioDefaultValueModel().volume
    }
    
    func startPlayer()  {
        let path = Bundle.main.path(forResource: "farah-faucet", ofType: "wav")!
        let url = NSURL.fileURL(withPath: path)
        let file = try? AVAudioFile(forReading: url)
        let buffer = AVAudioPCMBuffer(pcmFormat: file!.processingFormat, frameCapacity: AVAudioFrameCount(file!.length))
        do {
            try file!.read(into: buffer!)
        } catch _ {
            
        }
        pitch.pitch = AudioDefaultValueModel().pitch
        pitch.rate = AudioDefaultValueModel().rate
        engine.attach(player)
        engine.attach(pitch)
        engine.connect(player, to: pitch, format: buffer?.format)
        engine.connect(pitch, to: engine.mainMixerNode, format: buffer?.format)
        player.scheduleBuffer(buffer!, at: nil, options: AVAudioPlayerNodeBufferOptions.loops, completionHandler: nil)
        engine.prepare()
        do {
            try engine.start()
        } catch _ {
        }
        player.play()
    }
    
    func stopPlayer()  {
        player.stop()
    }
    
    
    func changePitchValue(pitchValue:Float, rateValue:Float)  {
        pitch.pitch = pitchValue
        pitch.rate = rateValue
        self.isPitchValueChanged = true
    }
    
    func changeRateValue(rateValue:Float)  {
        pitch.rate = rateValue
        self.isRateValueChanged = true
    }
    
}
