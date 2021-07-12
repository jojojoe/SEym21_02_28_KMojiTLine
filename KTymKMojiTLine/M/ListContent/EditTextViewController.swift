//
//  EditTextViewController.swift
//  FancyTextlineEmojiCapiton
//
//  Created by 薛忱 on 2021/6/8.
//

import UIKit
import SVProgressHUD

class EditTextViewController: UIViewController {
    
//    let contentView = UIScrollView()
    
    var titleStr = ""
    var currentStr = ""
    
    let contentLabel = UITextView()
    var style: ListVCStyle = .caption
    var dataArray = [""]
    let copyButton = UIButton()
    
    var needMoney = false
    var abcView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#272423")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardDidShow(notification:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardDidHide(notification:)),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)

        // Do any additional setup after loading the view.
        
//        contentView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        self.view.addSubview(contentView)
//        contentView.snp.makeConstraints { make in
//            make.top.left.bottom.right.equalTo(0)
//        }
        
        let backBtnBgImgV = UIImageView(image: UIImage(named: "kaomoji_back_background"))
        view.addSubview(backBtnBgImgV)
        backBtnBgImgV.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.width.equalTo(186/2)
            $0.height.equalTo(194/2)
        }
        
        let backButton = UIButton()
        backButton.backgroundColor = .clear
        backButton.setImage(UIImage(named: "ic_back"), for: .normal)
        backButton.addTarget(self, action: #selector(backbuttonClick(button:)), for: .touchUpInside)
        view.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            $0.left.equalTo(10)
            $0.width.height.equalTo(44)
        }
        //
        let shareButton = UIButton()
        shareButton.backgroundColor = .clear
        shareButton.setImage(UIImage(named: "ic_share"), for: .normal)
        shareButton.addTarget(self, action: #selector(sharebuttonClick(button:)), for: .touchUpInside)
        view.addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.right.equalTo(-10)
            make.centerY.equalTo(backButton)
        }
        
      
        let topLabel = UILabel()
        view.addSubview(topLabel)
        topLabel.font = UIFont(name: "Verdana-Bold", size: 24)
        topLabel.textColor = UIColor(hexString: "#FFFFFF")
        view.addSubview(topLabel)
        topLabel.snp.makeConstraints {
            $0.centerY.equalTo(backButton)
            $0.centerX.equalToSuperview()
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
        let bgOverLayerImgV = UIImageView(image: UIImage(named: "kaomoji_background"))
        bgOverLayerImgV.contentMode = .scaleAspectFit
        view.addSubview(bgOverLayerImgV)
        bgOverLayerImgV.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.width * (986/750))
        }
        //
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        self.view.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.top.equalTo(backButton.snp.bottom).offset(60)
            $0.bottom.equalTo(-100)
        }
        abcView = contentView
        
        //
        let toolView = UIView()
        toolView.backgroundColor = .white
        toolView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        
        let hideButton = UIButton()
        hideButton.setImage(UIImage(named: "ic_keyboared"), for: .normal)
        hideButton.backgroundColor = UIColor.init(hexString: "ic_keyboared")
        hideButton.addTarget(self, action: #selector(hideButtonClick(button:)), for: .touchUpInside)
        toolView.addSubview(hideButton)
        hideButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
        }
        //
        
        copyButton.backgroundColor = UIColor(hexString: "#FFBE3F")
        copyButton.layer.cornerRadius = 24
        copyButton.setTitle("Copy", for: .normal)
        copyButton.setTitleColor(.white, for: .normal)
        copyButton.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 18)
        
        copyButton.addTarget(self, action: #selector(copyButonClick(button:)), for: .touchUpInside)
        contentView.addSubview(copyButton)
        copyButton.snp.makeConstraints { make in
            make.left.equalTo(38)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-20)
        }
        
        //
        contentLabel.textAlignment = .center
        contentLabel.textColor = .black
        contentLabel.backgroundColor = .clear
        contentLabel.inputAccessoryView = toolView
        
        if style == .emoji {
            contentLabel.font = UIFont(name: "PingFangSC-Semibold", size: 22)
        } else {
            contentLabel.font = UIFont(name: "PingFangSC-Semibold", size: 16)
        }
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            if style == .emoji {
                make.top.equalTo(50)
            } else {
                make.top.equalTo(50)
            }
            
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(copyButton.snp.top).offset(-10)
        }
        
        //
        
        
        let randomButton = UIButton()
        randomButton.backgroundColor = .clear
        randomButton.setBackgroundImage(UIImage(named: "random_background"), for: .normal)
        randomButton.setImage(UIImage(named: "ic_random"), for: .normal)
        randomButton.setTitle(" Random", for: .normal)
        randomButton.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 14)
        randomButton.addTarget(self, action: #selector(randomButtonClick(button:)), for: .touchUpInside)
        view.addSubview(randomButton)
        randomButton.snp.makeConstraints {
            $0.width.equalTo(160)
            $0.height.equalTo(51)
            $0.centerY.equalTo(contentView.snp.top)
            $0.centerX.equalToSuperview()
        }
        
        //
        
        needMoney(need: self.needMoney)
        
        switch style {
        case .caption:
            self.dataArray = captionArray
            backBtnBgImgV.image = UIImage(named: "caption_back_background")
            copyButton.backgroundColor = UIColor(hexString: "#7449AB")
            bgOverLayerImgV.image = UIImage(named: "caption_background")
            topLabel.text = "Caption"
            break
            
        case .emoji:
            self.dataArray = emojiArray
            backBtnBgImgV.image = UIImage(named: "cuteemoji_back_background")
            copyButton.backgroundColor = UIColor(hexString: "#22C2F4")
            bgOverLayerImgV.image = UIImage(named: "cuteemoji_background")
            topLabel.text = "CuteEmoji"
            break
            
        case .textLine:
            self.dataArray = textlineArray
            backBtnBgImgV.image = UIImage(named: "textlinei_back_background")
            copyButton.backgroundColor = UIColor(hexString: "#FFBE3F")
            bgOverLayerImgV.image = UIImage(named: "textline_background")
            topLabel.text = "Textline"
            break
            
        case .kaomoji:
            self.dataArray = komojiArray
            backBtnBgImgV.image = UIImage(named: "kaomoji_back_background")
            copyButton.backgroundColor = UIColor(hexString: "#E84435")
            bgOverLayerImgV.image = UIImage(named: "kaomoji_background")
            topLabel.text = "Kaomoji"
            break
        }
    }
    
    @objc func hideButtonClick(button: UIButton) {
        self.contentLabel.resignFirstResponder()
    }
    
    @objc func keyBoardDidShow(notification: Notification) {
//        UIView.animate(withDuration: 0.3) {
//            self.contentView.contentOffset = CGPoint(x: 0, y: 100)
//        }
    }
    
    @objc func sharebuttonClick(button: UIButton) {
        copyButton.isHidden = true
        abcView.layer.cornerRadius = 0
        let image = abcView.changeToImage()
        copyButton.isHidden = false
        abcView.layer.cornerRadius = 20
        let activityItems = [image] as [Any]
        let toVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        present(toVC, animated: true, completion: nil)
        toVC.completionWithItemsHandler = {[weak self] activityType, completed, returnedItems, activityError in
            
            guard let `self` = self else {return}
            
            if activityType == nil {
                
            } else if activityType == .copyToPasteboard {
                self.copy(need: self.needMoney, contentText: self.contentLabel.text)
            } else {
                let alert = UIAlertController(title: "", message: completed ? "Share Success" : "Share Fail", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default) { (action) in
                }
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    
    @objc func keyBoardDidHide(notification: Notification) {
        UIView.animate(withDuration: 0.3) {
//            self.contentView.contentOffset = CGPoint(x: 0, y: 0)
        }
    }
    
    @objc func randomButtonClick(button: UIButton) {
        
        switch style {
        case .caption:
            let randomValue = Int(arc4random()) % captionArray.count
            let row = randomValue == 0 ? 0 : randomValue - 1
            needMoney(need: row > 1)
            self.contentLabel.text = captionArray[row]
            break
        
        case .emoji:
            let randomValue = Int(arc4random()) % emojiArray.count
            let row = randomValue == 0 ? 0 : randomValue - 1
            needMoney(need: row > 1)
            self.contentLabel.text = emojiArray[row]
            break
            
        case .textLine:
            let randomValue = Int(arc4random()) % textlineArray.count
            let row = randomValue == 0 ? 0 : randomValue - 1
            needMoney(need: row > 1)
            self.contentLabel.text = textlineArray[row]
            break
            
        case .kaomoji:
            let randomValue = Int(arc4random()) % komojiArray.count
            let row = randomValue == 0 ? 0 : randomValue - 1
            needMoney(need: row > 1)
            self.contentLabel.text = komojiArray[row]
            break
            
        }
    }
    
    func needMoney(need: Bool) {
        self.needMoney = need
        if need {
            copyButton.setTitle("Copy -\(FKbCoinMana.default.coinCostCount)Coins", for: .normal)
            
        } else {
            copyButton.setTitle("Copy", for: .normal)
            
        }
    }
    
    @objc func copyButonClick(button: UIButton) {
        copy(need: self.needMoney, contentText: self.contentLabel.text)
    }
    
    func copy(need: Bool, contentText: String) {
        
        if need {
            if FKbCoinMana.default.coinCount < FKbCoinMana.default.coinCostCount {
                let alert = UIAlertController(title: "Not enough coins are available.", message: "Do you want to buy some coins?", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default) {[weak self] (action) in
                    DispatchQueue.main.async {
                        let storeVC = CyHStoreVC()
                        storeVC.modalPresentationStyle = .fullScreen
                        self?.navigationController?.pushViewController(storeVC)
                        
                    }
                }
                let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                }

                alert.addAction(okButton)
                alert.addAction(cancelButton)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            let alertView = AlertView()
            self.view.addSubview(alertView)
            alertView.snp.makeConstraints { make in
                make.top.left.bottom.right.equalTo(0)
            }
            alertView.show()
            alertView.clickBlock = {
                FKbCoinMana.default.costCoin(coin: FKbCoinMana.default.coinCostCount)
                
                let border = UIPasteboard.general
                border.string = contentText
                
                let alert = UIAlertController(title: "", message: "Copy successfully", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default) { (action) in
                }
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let border = UIPasteboard.general
            border.string = contentText
            
            let alert = UIAlertController(title: "", message: "Copy successfully", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default) { (action) in
            }
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.contentLabel.becomeFirstResponder()
    }
    
    @objc func backbuttonClick(button: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
     
}

