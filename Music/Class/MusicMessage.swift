//
//  MusicMessage.swift
//  Music
//
//  Created by WangPengHui on 16/10/27.
//  Copyright © 2016年 美鲜冻品商城. All rights reserved.
//

import UIKit
import AVFoundation

//App单例
class AppInfo :NSObject,AVAudioPlayerDelegate{
    //单例
    static let sharedInstance = AppInfo()
    //音乐列表数组
    var musicList:[SongMessage] = []
    //播放单例
    var audioPlayer:AVAudioPlayer?
    //正在播放的歌曲在数组的下标
    var index:Int = 0
    //是否播放
    var isPlay:Bool = false {
        didSet {
            if self.isPlay {
                //播放
                if self.audioPlayer != nil {
                    self.audioPlayer?.play()
                }else {
                    playMusic(index: self.index)
                }
            }else {
                //暂停
                self.audioPlayer?.pause()
            }
        }
    }
    
    override init() {
        
        super.init()
        //添加歌曲到数组
        musicList.append(SongMessage(id: "1", name: "7862343-1.mp4", type: "2"))
        
    }
    //初始化本地Url
    func contentsURLWith(name: String) -> URL {
        let urlStr:String = Bundle.main.path(forResource: "7862343-1", ofType: "mp4")!
        return URL(fileURLWithPath: urlStr)
        
    }
    //播放音乐
    func playMusic(index:Int) {
        //将id穿进
        //先从本地查找
        do {
            
            let song:SongMessage = musicList[index]
            
            self.audioPlayer = try AVAudioPlayer(contentsOf: contentsURLWith(name: song.name!))
            
        }catch {
            
            DLog(message: "初始化失败")
            
        }
        //设置播放器属性
        //设置为0不循环
        self.audioPlayer?.numberOfLoops = 0;
        //设置音量大小为一半
        self.audioPlayer?.volume = 0.5;
        
        self.audioPlayer!.delegate = self
        
        self.audioPlayer?.addObserver(self, forKeyPath: "currentTime", options: .new, context: nil)
        //设置代理
        self.audioPlayer?.prepareToPlay()
        
        self.audioPlayer?.play()
    }
    //下一曲
    func nextMusic() {
        DLog(message: "next")
        if self.index == self.musicList.count - 1 {
            self.index = 0
        }else {
            self.index += 1
        }
        playMusic(index: self.index)
    }
    //上一曲
    func lastMusic() {
        DLog(message: "last")
        if self.index == 0 {
            self.index = self.musicList.count - 1
        }else {
            self.index -= 1
        }
        playMusic(index: self.index)
    }
    //音频播放完成后调用
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //列表播放
        if self.index == self.musicList.count - 1 {
            self.index = 0
        }else {
            self.index += 1
        }
        playMusic(index: self.index)
    }
    //音频解码发生错误后调用
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        DLog(message: error)
    }
    
}

//歌曲的信息
class SongMessage {
    //歌曲标号
    var id:String?
    //歌曲名字
    var name:String?
    //歌曲的格式
    var type:String?
    
    init(id:String, name:String, type:String) {
        self.id = id
        self.name = name
        self.type = type
    }
    
}
