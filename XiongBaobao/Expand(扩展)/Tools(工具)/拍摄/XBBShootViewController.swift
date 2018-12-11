//
//  XBBShootViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/23.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBShootViewController: UIViewController {

    //根据输入设备初始化设备输入对象，用于获得输入数据
    private lazy var captureDeviceInput: AVCaptureDeviceInput? = {
        let deviceInput = try? AVCaptureDeviceInput(device: self.camera(position: .back)!)
        if deviceInput == nil {
            return nil
        }
        return deviceInput
    }()
    
    private lazy var palyerVc: XBBShootPlayerViewController = {
        let vc = XBBShootPlayerViewController()
        return vc
    }()
    
    //视频输出流
    private lazy var captureMovieFileOutput: AVCaptureMovieFileOutput = {
        let fileOutput = AVCaptureMovieFileOutput()
        return fileOutput
    }()
    
    var captureVideoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    private lazy var captureSession: AVCaptureSession? = {
        let session = AVCaptureSession()
        session.sessionPreset = .high
        //添加一个音频输入设备
        let audioCaptureDevice = AVCaptureDevice.default(for: AVMediaType.audio)
        let audioCaptureDeviceInput = try? AVCaptureDeviceInput(device: audioCaptureDevice!)
        if audioCaptureDeviceInput == nil {
            return nil
        }
        
        //将设备输入添加到会话中
        if session.canAddInput(self.captureDeviceInput!) {
            session.addInput(self.captureDeviceInput!)
            session.addInput(audioCaptureDeviceInput!)
            let captureConnection = self.captureMovieFileOutput.connection(with: .video)
            // 标识视频录入时稳定音频流的接受，我们这里设置为自动
            captureConnection?.preferredVideoStabilizationMode = .auto
        }
        
         //将设备输出添加到会话中
        if session.canAddOutput(self.captureMovieFileOutput) {
            session.addOutput(self.captureMovieFileOutput)
        }
        return session
    }()
    
    //显示视频的内容,用来显示录像内容
    private lazy var userCamera: UIView = {
        let view = UIView(frame: self.view.bounds)
        view.backgroundColor = UIColor.black
        return view
    }()
    
    //视频保存地址
    private lazy var localMovieUrl: URL = {
        let url = URL(fileURLWithPath: NSTemporaryDirectory() + "src.mp4")
        return url
    }()
    
    //拍摄条
    private lazy var toolBar: ShootToolBar = {
        let bar = ShootToolBar(frame: self.view.bounds)
        bar.delegate = self
        bar.backgroundColor = UIColor.clear
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !NSObject.judgeSystemAuthority(type: .video) {
            return
        }
        
        if !NSObject.judgeSystemAuthority(type: .audio) {
            return
        }

        self.view.addSubview(self.userCamera)
        self.view.addSubview(self.toolBar)
        
        addChild(self.palyerVc)
        createPreviewLayer()
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground(notification:)), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.captureSession?.startRunning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.captureSession?.stopRunning()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension XBBShootViewController {
    
    @objc func applicationDidEnterBackground(notification: NotificationCenter) {
        stopRecordVideo()
    }
    
    //创建视频预览层，用于实时展示摄像头状态
    func createPreviewLayer() {
        self.captureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession!)
        let layer = self.userCamera.layer
        layer.masksToBounds = true
        self.captureVideoPreviewLayer!.frame = layer.bounds
        //填充模式
        self.captureVideoPreviewLayer!.videoGravity = .resizeAspectFill
        layer.addSublayer(self.captureVideoPreviewLayer!)
    }
    
    //获取指定摄像头
    func camera(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let device = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: .video, position: position)
        for device in device.devices {
            if device.position == position {
                return device
            }
        }
        return nil
    }
    
    //切换摄像头
    func changeCamera() {
        var newVideoInput: AVCaptureDeviceInput? = nil
        let position = self.captureDeviceInput?.device.position
        let device = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: .video, position: position!)
        if (device != nil) {
            if position == .back {
                newVideoInput = try? AVCaptureDeviceInput(device: self.camera(position: .front)!)
            } else if position == .front {
                newVideoInput = try? AVCaptureDeviceInput(device: self.camera(position: .back)!)
            }
            if (newVideoInput != nil) {
                self.captureSession?.beginConfiguration()
                self.captureSession?.removeInput(self.captureDeviceInput!)
                if (self.captureSession?.canAddInput(newVideoInput!))! {
                    self.captureSession?.addInput(newVideoInput!)
                    self.captureDeviceInput = newVideoInput
                } else {
                    self.captureSession?.addInput(self.captureDeviceInput!)
                }
                self.captureSession?.commitConfiguration()
            }
        }
    }
    
    // 开始录制视频
    func startRecordVideo() {
        let connection = self.captureMovieFileOutput.connection(with: .video)
        if !(self.captureSession?.isRunning)! {
            self.captureSession?.startRunning()
        }
        
        //根据连接取得设备输出的数据
        if !self.captureMovieFileOutput.isRecording {
            //如果输出 没有录制
            //如果支持多任务则开始多任务
            if UIDevice.current.isMultitaskingSupported {
                UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
            }
            //预览图层和视频方向保持一致
            connection?.videoOrientation = (self.captureVideoPreviewLayer!.connection?.videoOrientation)!
            //开始录制视频使用到了代理 AVCaptureFileOutputRecordingDelegate 同时还有录制视频保存的文件地址
            self.captureMovieFileOutput.startRecording(to: self.localMovieUrl, recordingDelegate: self)
        }
    }
    
    //停止录制视频
    func stopRecordVideo() {
        if self.captureMovieFileOutput.isRecording {
            self.captureMovieFileOutput.stopRecording()
        }
        if (self.captureSession?.isRunning)! {
            self.captureSession?.stopRunning()
        }
    }
}

extension XBBShootViewController: ShootToolBarDelegate {
    func shootToolBarAction(index: NSInteger) {
        if index == 1 { // 关闭
            dismiss(animated: true, completion: nil)
        }
        
        if index == 2 { //切换摄像头
            changeCamera()
        }
        
        if index == 3 { //重新拍摄
            self.palyerVc.playerLayer?.removeFromSuperlayer()
            self.palyerVc.player?.pause()
            self.captureSession?.startRunning()
        }
        
        if index == 4 { //完成
            
        }
    }
    
    func shootStart(button: ShootToolBar, progress: CGFloat) {
        startRecordVideo()
    }
    
    func shootEnd(button: ShootToolBar) {
        self.view.insertSubview(self.palyerVc.view, aboveSubview: self.userCamera)
        stopRecordVideo()
        self.palyerVc.url = self.localMovieUrl
    }
}

extension XBBShootViewController: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
    }
}
