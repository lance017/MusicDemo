//
//  PlayViewController.swift
//  Music
//
//  Created by WangPengHui on 16/10/26.
//  Copyright © 2016年 美鲜冻品商城. All rights reserved.
//

import UIKit

class PlayViewController: BaseViewController {
    
    let appInfo:AppInfo = AppInfo.sharedInstance
    
    lazy var bgView: UIImageView = {
        let imageView = UIImageView(frame: ScreenBounds)
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "cm2_fm_bg")
        return imageView
    }()
    
    lazy var playView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var centerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cm2_vehicle_btn_play"), for: .normal)
        button.setImage(UIImage(named: "cm2_vehicle_btn_play_prs"), for: .highlighted)
        button.addTarget(self, action: #selector(PlayViewController.playMusic(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cm2_vehicle_btn_next"), for: .normal)
        button.setImage(UIImage(named: "cm2_vehicle_btn_next_prs"), for: .highlighted)
        button.addTarget(self, action: #selector(PlayViewController.nextMusic), for: .touchUpInside)
        return button
    }()
    
    lazy var lastButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cm2_vehicle_btn_prev"), for: .normal)
        button.setImage(UIImage(named: "cm2_vehicle_btn_prev_prs"), for: .highlighted)
        button.addTarget(self, action: #selector(PlayViewController.lastMusic), for: .touchUpInside)
        return button
    }()
    
    var isPlay: Bool  = false {
        willSet(newIsPlay) {
            if newIsPlay {
                self.centerButton.setImage(UIImage(named: "cm2_vehicle_btn_pause"), for: .normal)
                self.centerButton.setImage(UIImage(named: "cm2_vehicle_btn_pause_prs"), for: .highlighted)
            }else {
                self.centerButton.setImage(UIImage(named: "cm2_vehicle_btn_play"), for: .normal)
                self.centerButton.setImage(UIImage(named: "cm2_vehicle_btn_play_prs"), for: .highlighted)
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.addSubview(self.bgView)
        
        self.bgView.addSubview(self.playView)

        self.playView.addSubview(self.centerButton)

        self.playView.addSubview(self.nextButton)

        self.playView.addSubview(self.lastButton)

        self.playView.snp.remakeConstraints { (make) in
            make.left.right.bottom.equalTo(self.bgView)
            make.height.equalTo(60)
        }
        
        self.centerButton.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        
        self.centerButton.snp.remakeConstraints { (make) in
            make.center.equalTo(self.playView.snp.center)
            make.width.height.equalTo(45)
        }
        
        self.nextButton.snp.remakeConstraints { (make) in
            make.centerY.equalTo(self.playView)
            make.left.equalTo(self.centerButton.snp.right).offset(40)
            make.width.height.equalTo(35)
        }
        
        self.lastButton.snp.remakeConstraints { (make) in
            make.centerY.equalTo(self.playView)
            make.right.equalTo(self.centerButton.snp.left).offset(-40)
            make.width.height.equalTo(35)
        }
        // Do any additional setup after loading the view.
    }
    //下一曲
    @objc func nextMusic() {
        DLog(message: "next")
        self.appInfo.nextMusic()
    }
    //上一曲
    @objc func lastMusic() {
        DLog(message: "last")
        self.appInfo.lastMusic()
    }
    //暂停播放
    @objc func playMusic(button: UIButton) {
        DLog(message: "play")
        self.isPlay = !self.isPlay
        self.appInfo.isPlay = self.isPlay
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
