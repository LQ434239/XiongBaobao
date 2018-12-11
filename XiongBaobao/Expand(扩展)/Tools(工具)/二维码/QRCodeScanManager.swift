//
//  QRCodeScanManager.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/9.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit
import AVFoundation

//扫描出结果
typealias ScanFinishedBlock = (_ result: String) -> Void

//监听环境光感
typealias MonitorLightBlock = (_ brightness: CGFloat) -> Void

class QRCodeScanManager: NSObject {
    static let shard = QRCodeScanManager()
    
    var scanFinished: ScanFinishedBlock?
    var monitorLight: MonitorLightBlock?
    
    private lazy var session: AVCaptureSession? = {
        // 获取摄像设备
        let device = AVCaptureDevice.default(for: .video)
        // 创建摄像设备输入流
        let input = try? AVCaptureDeviceInput.init(device: device!)
        if input == nil {
            return nil
        }
        //创建二维码扫描输出流
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        //创建环境光感输出流
        let lightOutput = AVCaptureVideoDataOutput()
        lightOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        
        let session = AVCaptureSession()
        //设置扫码支持的编码格式(这里设置条形码和二维码兼容)
        session.sessionPreset = .hd1920x1080
        session.addInput(input!)
        session.addOutput(output)
        session.addOutput(lightOutput)
        
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr,
                                      AVMetadataObject.ObjectType.ean13,
                                      AVMetadataObject.ObjectType.ean8,
                                      AVMetadataObject.ObjectType.code128]
        return session
    }()
}

extension QRCodeScanManager: AVCaptureMetadataOutputObjectsDelegate,AVCaptureVideoDataOutputSampleBufferDelegate {
    
    //摄像头捕获
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        print(metadataObjects)
        if metadataObjects.count > 0 {
            let metadataObject: AVMetadataMachineReadableCodeObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            if self.scanFinished != nil {
                self.scanFinished!(metadataObject.stringValue!)
            }
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    
        let metadataDict: CFDictionary = CMCopyDictionaryOfAttachments(allocator: nil, target: sampleBuffer, attachmentMode: kCMAttachmentMode_ShouldPropagate)!
        let key = Unmanaged.passRetained(kCGImagePropertyExifDictionary as NSString).autorelease().toOpaque()
        let exifMetadata = CFDictionaryGetValue(metadataDict, key)
        
        let result = Unmanaged<NSDictionary>.fromOpaque(exifMetadata!).takeUnretainedValue()
        let brightnessValue = result["BrightnessValue"]!
        if self.monitorLight != nil {
            self.monitorLight!(brightnessValue as! CGFloat)
        }
    }
}

extension QRCodeScanManager {
    func setupSessionPreview(preview: UIView) {
        let layer = AVCaptureVideoPreviewLayer(session: self.session!)
        layer.videoGravity = .resizeAspectFill
        layer.frame = preview.layer.bounds
        preview.layer.insertSublayer(layer, at: 0)
        self.startRunning()
    }
    
    //开启会话对象扫描
    func startRunning() {
        self.session?.startRunning()
    }
    
    //停止会话对象扫描
    func stopRunning() {
        self.session?.stopRunning()
    }
}
