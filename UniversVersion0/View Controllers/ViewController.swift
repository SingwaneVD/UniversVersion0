//
//  ViewController.swift
//  UniversVersion0
//
//  Created by IACD-024 on 2022/06/21.
//

import UIKit
import AVKit

class ViewController: UIViewController {
   
    var videoPlayer:AVPlayer? //optiopnal because I will initialize or create the object then initialize it later
    var videoPlayerLayer:AVPlayerLayer?
    
    
    @IBOutlet var signUpBtn: UIButton!
    @IBOutlet var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
        
     }
    
    //viewWillApppear rather than viewDidLoad ,bcs we working with something that will be visually displayed, you will run into problems, use ViewWillAppear or viewDidAppear for playing videos,sounds,and maps(map transition to a specific region)
    override func viewWillAppear(_ animated: Bool) {
        //set up video in the background
        setUpVideo()
    }
    
     func setUpElements(){
        //styling the elements
         Utilities.styleHollowButton(loginBtn)
        /* loginBtn.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
         loginBtn.layer.cornerRadius = 25.0
         loginBtn.tintColor = UIColor.white */
         Utilities.styleFilledButton(signUpBtn)
     }
    
    func setUpVideo(){
        //get the path to the resource in the bundle
       let bundlePath = Bundle.main.path(forResource: "Graduates Caps", ofType: "mp4")
        guard bundlePath != nil else {
            return
        }
        //Create a URL from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        // create the video player item
        let item = AVPlayerItem(url: url)
        //create the player
        videoPlayer = AVPlayer(playerItem: item)
        //create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        //adjust the frame and size
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        //Add the video to the view and play it
        videoPlayer?.playImmediately(atRate: 0.50)
        
    }

}

