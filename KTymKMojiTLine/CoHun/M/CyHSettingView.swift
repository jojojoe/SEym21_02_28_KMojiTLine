//
//  CyHSettingView.swift
//  CyHymChangeHair
//
//  Created by JOJO on 2021/7/2.
//

import UIKit
import MessageUI
import StoreKit
import Defaults
import NoticeObserveKit
import DeviceKit

let AppName: String = "Kaomoji"
let purchaseUrl = ""
let TermsofuseURLStr = "https://www.app-privacy-policy.com/live.php?token=JvjoxRcG2IBAAiIWrhqQ9LcmiII9aLoR"
let PrivacyPolicyURLStr = "https://www.app-privacy-policy.com/live.php?token=DbcLKTrdTObbxSTnwKejx5K1DW4EIkCv"
let feedbackEmail: String = "vovwoucieo@yandex.com"
let AppAppStoreID: String = ""


class CASeTTingVC: UIViewController {
   let userPlaceIcon = UIImageView(image: UIImage(named: "setting_head"))
   let userNameLabel = UILabel()
   let feedbackBtn = SettingContentBtn(frame: .zero, name: "Feedback", iconImage: UIImage(named: "setting_button_background")!)
   let privacyLinkBtn = SettingContentBtn(frame: .zero, name: "Privacy Policy", iconImage: UIImage(named: "setting_button_background")!)
   let termsBtn = SettingContentBtn(frame: .zero, name: "Terms of use", iconImage: UIImage(named: "setting_button_background")!)
//   let logoutBtn = SettingContentBtn(frame: .zero, name: "Log out", iconImage: UIImage(named: "setting_log")!)
   let loginBtn = UIButton(type: .custom)
   let backBtn = UIButton(type: .custom)
   
   override func viewDidLoad() {
       super.viewDidLoad()
       view.backgroundColor = UIColor(hexString: "#272423")
    
       setupView()
       setupContentView()
//       updateUserAccountStatus()
       
   }
   override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
//       updateUserAccountStatus()
   }
}

extension CASeTTingVC {
   @objc func backBtnClick(sender: UIButton) {
       if self.navigationController != nil {
           self.navigationController?.popViewController()
       } else {
           self.dismiss(animated: true, completion: nil)
       }
   }
}

extension CASeTTingVC {
   func setupView() {
       //
    //
    let backBtnBgImgV = UIImageView(image: UIImage(named: "setting_back_background"))
    view.addSubview(backBtnBgImgV)
    backBtnBgImgV.snp.makeConstraints {
        $0.left.top.equalToSuperview()
        $0.width.equalTo(186/2)
        $0.height.equalTo(194/2)
    }
    
       view.addSubview(backBtn)
       backBtn.addTarget(self, action: #selector(backBtnClick(sender:)), for: .touchUpInside)
       backBtn.setImage(UIImage(named: "ic_back"), for: .normal)
       backBtn.snp.makeConstraints {
           $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
           $0.left.equalTo(10)
           $0.width.height.equalTo(44)
       }
       //
       let namelabel = UILabel()
       namelabel.font = UIFont(name: "Verdana-Bold", size: 24)
       namelabel.textColor = UIColor(hexString: "#FFFFFF")
       namelabel.textAlignment = .center
       namelabel.text = "Setting"
       view.addSubview(namelabel)
       namelabel.adjustsFontSizeToFitWidth = true
       namelabel.snp.makeConstraints {
           $0.centerY.equalTo(backBtn)
           $0.centerX.equalToSuperview()
           $0.width.greaterThanOrEqualTo(1)
           $0.height.greaterThanOrEqualTo(1)
       }
    
    let bgBottomImgV = UIImageView(image: UIImage(named: "home_background"))
    view.addSubview(bgBottomImgV)
    bgBottomImgV.snp.makeConstraints {
        $0.left.right.bottom.equalTo(view)
        $0.height.equalTo(UIScreen.main.bounds.width * 262/750)
    }
//    750 × 262
    
       //
       /*
       view.addSubview(userPlaceIcon)
       userPlaceIcon.snp.makeConstraints {
           $0.centerX.equalToSuperview()
           $0.top.equalTo(namelabel.snp.bottom).offset(40)
           $0.width.height.equalTo(176/2)
       }
       
       //
       userNameLabel.font = UIFont(name: "Poppins-Bold", size: 18)
//        userNameLabel.layer.shadowColor = UIColor(hexString: "#292929")?.cgColor
//        userNameLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
//        userNameLabel.layer.shadowRadius = 3
//        userNameLabel.layer.shadowOpacity = 0.8
       userNameLabel.textColor = UIColor(hexString: "#292929")
       userNameLabel.textAlignment = .center
       userNameLabel.text = "Log in"
       view.addSubview(userNameLabel)
       userNameLabel.adjustsFontSizeToFitWidth = true
       userNameLabel.snp.makeConstraints {
           $0.top.equalTo(userPlaceIcon.snp.bottom).offset(10)
           $0.centerX.equalToSuperview()
           $0.left.equalTo(40)
           $0.height.greaterThanOrEqualTo(1)
       }
       //
       */
       
   }
   @objc func loginBtnClick(sender: UIButton) {
//       self.showLoginVC()
   }
   //
   func setupContentView() {
    /*
       view.addSubview(loginBtn)
       loginBtn.addTarget(self, action: #selector(loginBtnClick(sender:)), for: .touchUpInside)
        
       loginBtn.snp.makeConstraints {
           $0.left.right.equalTo(userPlaceIcon)
           $0.bottom.equalTo(userNameLabel.snp.bottom)
           $0.top.equalTo(userPlaceIcon.snp.top)
       }
       */
       
    // privacy link
    view.addSubview(privacyLinkBtn)
    privacyLinkBtn.clickBlock = {
        [weak self] in
        guard let `self` = self else {return}
        UIApplication.shared.openURL(url: PrivacyPolicyURLStr)
    }
    privacyLinkBtn.snp.makeConstraints {
        $0.width.equalTo(233)
        $0.height.equalTo(80)
        $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.centerY).offset(-20)
        $0.centerX.equalToSuperview()
    }
    
       // feedback
       view.addSubview(feedbackBtn)
       feedbackBtn.clickBlock = {
           [weak self] in
           guard let `self` = self else {return}
           self.feedback()
       }
       feedbackBtn.snp.makeConstraints {
        $0.width.equalTo(233)
        $0.height.equalTo(80)
           $0.bottom.equalTo(privacyLinkBtn.snp.top).offset(-22)
           $0.centerX.equalToSuperview()
       }
       
//        if Device.current.diagonal == 4.7 || Device.current.diagonal > 7 {
//            feedbackBtn.snp.makeConstraints {
//                $0.width.equalTo(357)
//                $0.height.equalTo(64)
//                $0.top.equalTo(userNameLabel.snp.bottom).offset(27)
//                $0.centerX.equalToSuperview()
//            }
//        } else {
//            feedbackBtn.snp.makeConstraints {
//                $0.width.equalTo(357)
//                $0.height.equalTo(64)
//                $0.top.equalTo(userNameLabel.snp.bottom).offset(37)
//                $0.centerX.equalToSuperview()
//            }
//        }
       
       
       // terms
       
       view.addSubview(termsBtn)
       termsBtn.clickBlock = {
           [weak self] in
           guard let `self` = self else {return}
           UIApplication.shared.openURL(url: TermsofuseURLStr)
       }
       termsBtn.snp.makeConstraints {
        $0.width.equalTo(233)
        $0.height.equalTo(80)
           $0.top.equalTo(privacyLinkBtn.snp.bottom).offset(22)
           $0.centerX.equalToSuperview()
       }
       
    /*
       // logout
       view.addSubview(logoutBtn)
       logoutBtn.clickBlock = {
           [weak self] in
           guard let `self` = self else {return}
           LoginMNG.shared.logout()
           self.updateUserAccountStatus()
       }
       logoutBtn.snp.makeConstraints {
           $0.width.equalTo(354)
           $0.height.equalTo(72)
           $0.top.equalTo(termsBtn.snp.bottom).offset(20)
           $0.centerX.equalToSuperview()
       }
       */
   }
   
   
}

extension CASeTTingVC {
    
   
//   func showLoginVC() {
//       if APLoginMana.currentLoginUser() == nil {
//           let loginVC = APLoginMana.shared.obtainVC()
//           loginVC.modalTransitionStyle = .crossDissolve
//           loginVC.modalPresentationStyle = .fullScreen
//
//           self.present(loginVC, animated: true) {
//           }
//       }
//   }
//   func updateUserAccountStatus() {
//       if let userModel = APLoginMana.currentLoginUser() {
//           let userName  = userModel.userName
//           userNameLabel.text = (userName?.count ?? 0) > 0 ? userName : AppName
////           logoutBtn.isHidden = false
////           loginBtn.isHidden = true
////            loginBtn.isUserInteractionEnabled = false
//
//       } else {
//           userNameLabel.text = "Log in"
////           logoutBtn.isHidden = true
////           loginBtn.isHidden = false
////            loginBtn.isUserInteractionEnabled = true
//
//       }
//   }
}

extension CASeTTingVC: MFMailComposeViewControllerDelegate {
   func feedback() {
       //首先要判断设备具不具备发送邮件功能
       if MFMailComposeViewController.canSendMail(){
           //获取系统版本号
           let systemVersion = UIDevice.current.systemVersion
           let modelName = UIDevice.current.modelName
           
           let infoDic = Bundle.main.infoDictionary
           // 获取App的版本号
           let appVersion = infoDic?["CFBundleShortVersionString"] ?? "8.8.8"
           // 获取App的名称
           let appName = "\(AppName)"

           
           let controller = MFMailComposeViewController()
           //设置代理
           controller.mailComposeDelegate = self
           //设置主题
           controller.setSubject("\(appName) Feedback")
           //设置收件人
           // FIXME: feed back email
           controller.setToRecipients([feedbackEmail])
           //设置邮件正文内容（支持html）
        controller.setMessageBody("\n\n\nSystem Version：\(systemVersion)\n Device Name：\(modelName)\n App Name：\(appName)\n App Version：\(appVersion )", isHTML: false)
           
           //打开界面
           self.present(controller, animated: true, completion: nil)
       }else{
           HUD.error("The device doesn't support email")
       }
   }
   
   //发送邮件代理方法
   func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
       controller.dismiss(animated: true, completion: nil)
       
   }
}

class SettingContentBtn: UIButton {
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
       nameLabel.textColor = UIColor(hexString: "#000000")
       nameLabel.font = UIFont(name: "Verdana-Bold", size: 18)
       nameLabel.snp.makeConstraints {
           $0.center.equalToSuperview()
           $0.left.equalTo(25)
           $0.width.height.greaterThanOrEqualTo(1)
       }
       
   }
   
}
