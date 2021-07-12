//
//  CymDatamanager.swift
//  CyHymChangeHair
//
//  Created by JOJO on 2021/7/2.
//


import UIKit
import GPUImage
import SwifterSwift


struct THymHairBundle: Codable {
    var logoImageName: String?
    var titleName: String?
    var bgColor: String?
    var items: [THymHairItem] = []
    
}
struct THymHairItem: Codable {
    var thumbnail: String?
    var big: String?
    var isPro: Bool?
    var isMan: Bool?
    
}

class GCFilterItem: Codable {

    let filterName : String
    let type : String
    let imageName : String
    
    enum CodingKeys: String, CodingKey {
        case filterName
        case type
        case imageName
    }
    
}


// filter
extension THDataManager {
    func filterOriginalImage(image: UIImage, lookupImgNameStr: String) -> UIImage? {
        
        if let gpuPic = GPUImagePicture(image: image), let lookupImg = UIImage(named: lookupImgNameStr), let lookupPicture = GPUImagePicture(image: lookupImg) {
            let lookupFilter = GPUImageLookupFilter()
            
            gpuPic.addTarget(lookupFilter, atTextureLocation: 0)
            lookupPicture.addTarget(lookupFilter, atTextureLocation: 1)
            lookupFilter.intensity = 0.7
            
            lookupPicture.processImage()
            gpuPic.processImage()
            lookupFilter.useNextFrameForImageCapture()
            let processedImage = lookupFilter.imageFromCurrentFramebuffer()
            return processedImage
        } else {
            return nil
        }
        return nil
    }
}

class THDataManager: NSObject {
    static let `default` = THDataManager()
    var manHairBundleList: [THymHairBundle] = []
    var girlHairBundleList: [THymHairBundle] = []
    
    var tattooBundleList: [THymHairBundle] = []
    var filterList : [GCFilterItem] {
        return THDataManager.default.loadPlist([GCFilterItem].self, name: "FilterList") ?? []
    }
    
    override init() {
        super.init()
        setupData()
    }
    
    
    func setupData() {
        manHairBundleList = loadJson([THymHairBundle].self, name: "manHairList") ?? []
        girlHairBundleList = loadJson([THymHairBundle].self, name: "girlHairList") ?? []
        tattooBundleList = loadJson([THymHairBundle].self, name: "tattooList") ?? []

        
    }
    
}



extension THDataManager {
    func loadJson<T: Codable>(_: T.Type, name: String, type: String = "json") -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                return try! JSONDecoder().decode(T.self, from: data)
            } catch let error as NSError {
                debugPrint(error)
            }
        }
        return nil
    }
    
    func loadJson<T: Codable>(_:T.Type, path:String) -> T? {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            do {
                return try PropertyListDecoder().decode(T.self, from: data)
            } catch let error as NSError {
                print(error)
            }
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    func loadPlist<T: Codable>(_:T.Type, name:String, type:String = "plist") -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            return loadJson(T.self, path: path)
        }
        return nil
    }
    
}
