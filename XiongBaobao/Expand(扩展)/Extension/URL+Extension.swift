//
//  URL+Extension.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/10.
//  Copyright © 2018 双双. All rights reserved.
//

extension URL {
    
    //压缩视频
    func compressionVideo(handler: @escaping (URL) -> Void) {
        let path = NSTemporaryDirectory().appending(kTimeStamp + ".mp4")
        //如果文件存在就删除
        try? FileManager.default.removeItem(atPath: path)
        let asset = AVAsset(url: self)
        let session = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetMediumQuality)
        //优化网络
        session?.shouldOptimizeForNetworkUse = true
        //设置输出路径
        session?.outputURL = URL(fileURLWithPath: path)
        //设置输出类型
        session?.outputFileType = .mp4
        session?.exportAsynchronously(completionHandler: {
            //压缩完成
            if session?.status == .completed {
                DispatchQueue.main.async {
                    print("压缩完毕")
                    handler((session?.outputURL)!)
                }
            }
        })
    }
}
