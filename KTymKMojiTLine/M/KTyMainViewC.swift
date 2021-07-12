//
//  KTyMainViewC.swift
//  KTymKMojiTLine
//
//  Created by JOJO on 2021/7/8.
//

import UIKit
import SwiftyStoreKit
import DeviceKit

class KTyMainViewC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        view.backgroundColor = UIColor(hexString: "#272423")
        let settingBtn = UIButton(type: .custom)
        view.addSubview(settingBtn)
        settingBtn.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.width.height.equalTo(61)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(18)
        }
        settingBtn.setImage(UIImage(named: "home_setting"), for: .normal)
        settingBtn.addTarget(self, action: #selector(settingBtnClick(sender:)), for: .touchUpInside)
        //
        let setoreBtn = UIButton(type: .custom)
        view.addSubview(setoreBtn)
        setoreBtn.snp.makeConstraints {
            $0.right.equalTo(-20)
            $0.width.equalTo(72)
            $0.height.equalTo(61)
            $0.centerY.equalTo(settingBtn)
        }
        setoreBtn.setImage(UIImage(named: "home_store"), for: .normal)
        setoreBtn.addTarget(self, action: #selector(stioreBtnClick(sender:)), for: .touchUpInside)
        //
        let nameTileLabel = UILabel()
        
//        5.5 6.7
        if Device.current.diagonal >= 5.5 && Device.current.diagonal <= 6.7 {
            nameTileLabel.font = UIFont(name: "Verdana-Bold", size: 30)
        } else {
            nameTileLabel.font = UIFont(name: "Verdana-Bold", size: 26)
        }
        
        nameTileLabel.text = "1000+ Emoticons Text For You"
        nameTileLabel.numberOfLines = 2
        nameTileLabel.textAlignment = .left
        nameTileLabel.adjustsFontSizeToFitWidth = true
        nameTileLabel.textColor = .white
        view.addSubview(nameTileLabel)
        
        if Device.current.diagonal >= 5.5 && Device.current.diagonal <= 6.7 {
            nameTileLabel.snp.makeConstraints {
                $0.left.equalTo(20)
                $0.top.equalTo(settingBtn.snp.bottom).offset(20)
                $0.width.equalTo(302)
                $0.height.equalTo(90)
            }
        } else {
            nameTileLabel.snp.makeConstraints {
                $0.left.equalTo(20)
                $0.top.equalTo(settingBtn.snp.bottom).offset(10)
                $0.width.equalTo(302)
                $0.height.equalTo(90)
            }
        }
        
        
        //
        let bottomBgView = UIImageView(image: UIImage(named: "home_background"))
        view.addSubview(bottomBgView)
        bottomBgView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(view)
            $0.height.equalTo(UIScreen.main.bounds.width * 262/750)
        }
        //
        let contentBgView = UIView()
        view.addSubview(contentBgView)
        contentBgView.snp.makeConstraints {
            $0.top.equalTo(nameTileLabel.snp.bottom)
            $0.bottom.equalTo(bottomBgView.snp.top)
            $0.left.right.equalToSuperview()
        }
        let contentBgOverImgV = UIImageView(image: UIImage(named: "home_background_star"))
        contentBgView.addSubview(contentBgOverImgV)
        contentBgOverImgV.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-50)
            $0.right.equalToSuperview().offset(-20)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
        let kaoMojiBtn = HOmeContentBtn(frame: .zero, name: "Kaomoji", iconImage: UIImage(named: "home_kaomoji")!)
        kaoMojiBtn.clickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(KomojiViewController())
            }
        }
        contentBgView.addSubview(kaoMojiBtn)
        kaoMojiBtn.snp.makeConstraints {
            $0.right.equalTo(contentBgView.snp.centerX).offset(-7)
            $0.bottom.equalTo(contentBgView.snp.centerY).offset(0)
            $0.width.height.equalTo(320/2)
        }
        //
        let captionBtn = HOmeContentBtn(frame: .zero, name: "Caption", iconImage: UIImage(named: "home_caption")!)
        captionBtn.clickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                let listVC = ListViewController()
                listVC.style = .caption
                self.navigationController?.pushViewController(listVC)
            }
        }
        contentBgView.addSubview(captionBtn)
        captionBtn.snp.makeConstraints {
            $0.left.equalTo(contentBgView.snp.centerX).offset(7)
            $0.bottom.equalTo(kaoMojiBtn.snp.bottom)
            $0.width.height.equalTo(320/2)
        }
        //
        let cuteEmojiBtn = HOmeContentBtn(frame: .zero, name: "CuteEmoji", iconImage: UIImage(named: "home_cuteemomji")!)
        cuteEmojiBtn.clickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                let listVC = ListViewController()
                listVC.style = .emoji
                self.navigationController?.pushViewController(listVC)
            }
        }
        contentBgView.addSubview(cuteEmojiBtn)
        cuteEmojiBtn.snp.makeConstraints {
            $0.right.equalTo(contentBgView.snp.centerX).offset(-7)
            $0.top.equalTo(contentBgView.snp.centerY).offset(35)
            $0.width.height.equalTo(320/2)
        }
        //
        let textlineBtn = HOmeContentBtn(frame: .zero, name: "Textline", iconImage: UIImage(named: "home_textline")!)
        textlineBtn.clickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                let listVC = ListViewController()
                listVC.style = .textLine
                self.navigationController?.pushViewController(listVC)
            }
        }
        contentBgView.addSubview(textlineBtn)
        textlineBtn.snp.makeConstraints {
            $0.left.equalTo(contentBgView.snp.centerX).offset(7)
            $0.top.equalTo(contentBgView.snp.centerY).offset(35)
            $0.width.height.equalTo(320/2)
        }
        
        
        
    }
    

}

extension KTyMainViewC {
    @objc func settingBtnClick(sender: UIButton) {
        self.navigationController?.pushViewController(CASeTTingVC())
    }
    
    @objc func stioreBtnClick(sender: UIButton) {
        self.navigationController?.pushViewController(CyHStoreVC())
    }
    
    
}




/*
 func fetchPrice() {
     
     let iapList = ["com.year", "com.month"]
     // 本地价格列表
     var localizedPriceList: [String: String] = [:]
     
     SwiftyStoreKit.retrieveProductsInfo(Set(iapList)) { [weak self] result in
         guard let `self` = self else { return }
         let iapProductsList = result.retrievedProducts.compactMap { $0 }
         
         for iapString in iapList {
             let model = iapProductsList.filter { $0.productIdentifier == iapString }.first
             if let price = model?.localizedPrice {
                  
                 localizedPriceList[iapString] = price
             }
         }
         //TODO: 刷新
         
     }
 }
 */






class HOmeContentBtn: UIButton {
   var clickBlock: (()->Void)?
   var nameTitle: String
   var iconImage: UIImage
   init(frame: CGRect, name: String, iconImage: UIImage) {
       self.nameTitle = name
       self.iconImage = iconImage
       super.init(frame: frame)
       setupView()
       addTarget(self, action: #selector(clickAction(sender:)), for: .touchUpInside)
   }
   
   @objc func clickAction(sender: UIButton) {
       clickBlock?()
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   func setupView() {
       self.backgroundColor = .clear
//        self.layer.cornerRadius = 17
//        self.layer.borderWidth = 4
//        self.layer.borderColor = UIColor.black.cgColor
       
       
       //
       let iconImgV = UIImageView(image: iconImage)
       iconImgV.contentMode = .scaleAspectFit
       addSubview(iconImgV)
       iconImgV.snp.makeConstraints {
           $0.left.right.bottom.top.equalToSuperview()
       }
       //
//
    
       let nameLabel = UILabel()
       addSubview(nameLabel)
       nameLabel.text = nameTitle
       nameLabel.textAlignment = .center
       nameLabel.textColor = UIColor(hexString: "#FFFFFF")
       nameLabel.font = UIFont(name: "Verdana-Bold", size: 18)
       nameLabel.snp.makeConstraints {
           $0.centerX.equalToSuperview()
           $0.left.equalTo(10)
           $0.height.greaterThanOrEqualTo(1)
        $0.bottom.equalTo(-34)
       }
       
   }
   
}



