//
//  AlertView.swift
//  FancyTextlineEmojiCapiton
//
//  Created by 薛忱 on 2021/6/8.
//

import UIKit
import SnapKit

typealias buttonClickBlock = () -> Void

class AlertView: UIView {
    
    let animetion = UIView()
    var clickBlock: buttonClickBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        animetion.backgroundColor = UIColor.clear
//        animetion.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        animetion.layer.masksToBounds = true
//        animetion.layer.cornerRadius = 32
        self.addSubview(animetion)
        animetion.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(40)
            $0.width.equalTo(UIScreen.main.bounds.width - 20 * 2)
            $0.height.equalTo((UIScreen.main.bounds.width - 20 * 2) * (684/678))
        }
        
        let topImageView = UIImageView()
        topImageView.image = UIImage(named: "costcoins_background")
        animetion.addSubview(topImageView)
        topImageView.snp.makeConstraints {
            $0.left.right.bottom.top.equalToSuperview()
        }
        
        let label = UILabel()
        
        label.text = "It is a paid item. \(FKbCoinMana.default.coinCostCount) coins will be deducted if you confirm the copy."
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Verdana-Bold", size: 18)
        label.numberOfLines = 0
        animetion.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(animetion.snp.centerY).offset(10)
            make.left.equalTo(53)
            make.right.equalTo(-53)
            make.height.greaterThanOrEqualTo(1)
        }

        let okButton = UIButton()
        
        okButton.setTitle("Copy -\(FKbCoinMana.default.coinCostCount)Coins", for: .normal)
        okButton.setTitleColor(.white, for: .normal)
        okButton.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 18)
        okButton.backgroundColor = UIColor(hexString: "#FFADB4")
        okButton.layer.cornerRadius = 24
        okButton.addTarget(self, action: #selector(okButtonClick(button:)), for: .touchUpInside)
        animetion.addSubview(okButton)
        okButton.snp.makeConstraints { make in
            make.left.equalTo(18)
            make.height.equalTo(48)
            make.bottom.equalTo(-16)
            make.centerX.equalToSuperview()
        }
        
        let cancelButton = UIButton()
        cancelButton.addTarget(self, action: #selector(cancelButtonClick(button:)), for: .touchUpInside)
        animetion.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(75)
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
    }
    
    @objc func cancelButtonClick(button: UIButton) {
        hiden()
    }
    
    @objc func okButtonClick(button: UIButton) {
        clickBlock?()
        hiden()
    }
    
    func show() {
        self.alpha = 0
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
            self.layoutIfNeeded()
        }
    }
    
    func hiden() {
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0
            self.layoutIfNeeded()
        } completion: { success in
            if success {
                self.removeFromSuperview()
            }
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
