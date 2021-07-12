//
//  KomojiCollectionViewCell.swift
//  FancyTextlineEmojiCapiton
//
//  Created by 薛忱 on 2021/6/7.
//

import UIKit


class KomojiCollectionViewCell: UICollectionViewCell {
    let contetnBgView = UIView()
    let cellLabel = UILabel()
    var cellIndexRow = -1
    var editButtonClickBlock: CELLBLOCK?
    var copyButtonClickBlock: CELLBLOCK?
    
    let editButton = UIButton()
    let copyButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        
        contetnBgView.backgroundColor = .white
        contetnBgView.layer.cornerRadius = 20
        contentView.addSubview(contetnBgView)
        contetnBgView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
        }
        
        editButton.layer.borderWidth = 3
        editButton.layer.borderColor = UIColor(hexString: "#E84435")?.cgColor
        editButton.layer.cornerRadius = 24
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(UIColor(hexString: "#E84435"), for: .normal)
        editButton.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 18)
        editButton.addTarget(self, action: #selector(editButtonClick(button:)), for: .touchUpInside)
        contetnBgView.addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-77)
        }
        
        
        
        copyButton.setTitle("Copy", for: .normal)
        copyButton.setTitleColor(.white, for: .normal)
        copyButton.backgroundColor = UIColor(hexString: "#E84435")
        copyButton.layer.cornerRadius = 24
        copyButton.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 18)
        copyButton.semanticContentAttribute = .forceRightToLeft
        copyButton.addTarget(self, action: #selector(copyButtonClick(button:)), for: .touchUpInside)
        contetnBgView.addSubview(copyButton)
        copyButton.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-20)
        }
        
        cellLabel.textAlignment = .center
        cellLabel.textColor = .black
        cellLabel.numberOfLines = 0
        cellLabel.font = UIFont(name: "PingFangSC-Semibold", size: 16)
        contetnBgView.addSubview(cellLabel)
        cellLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(25)
            make.bottom.equalTo(editButton.snp.top).offset(-20)
            make.left.equalTo(20)
        }
    }
    
    @objc func editButtonClick(button: UIButton) {
        editButtonClickBlock?(self.tag)
    }
    
    @objc func copyButtonClick(button: UIButton) {
        copyButtonClickBlock?(self.tag)
    }
    
    func copyButtonStyel(tag: Int) {
        
        if tag > 1 {
            copyButton.setTitle("Copy -\(FKbCoinMana.default.coinCostCount)Coins", for: .normal)
        } else {
            copyButton.setTitle("Copy", for: .normal)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
