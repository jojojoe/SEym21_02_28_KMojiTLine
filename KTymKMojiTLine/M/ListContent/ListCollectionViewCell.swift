//
//  ListCollectionViewCell.swift
//  FancyTextlineEmojiCapiton
//
//  Created by 薛忱 on 2021/6/7.
//

import UIKit

typealias CELLBLOCK = (Int) -> Void

class ListCollectionViewCell: UICollectionViewCell {
    
    let cellLabel = UILabel()
    var cellIndexRow = -1
    var editButtonClickBlock: CELLBLOCK?
    var copyButtonClickBlock: CELLBLOCK?
    
    let copyButton = UIButton()
    let editButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        self.contentView.cornerRadius = 20
        
 
        editButton.layer.cornerRadius = 24
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(UIColor(hexString: "#FFBE3F"), for: .normal)
        editButton.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 16)
        editButton.layer.borderWidth = 3
        editButton.layer.borderColor = UIColor(hexString: "#FFBE3F")?.cgColor
        editButton.layer.cornerRadius = 24
        editButton.addTarget(self, action: #selector(editButtonClick(button:)), for: .touchUpInside)
        self.contentView.addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.width.equalTo(123)
            make.height.equalTo(48)
            make.left.equalTo(12)
            make.bottom.equalTo(-13)
        }
        
        
        copyButton.layer.cornerRadius = 24
        copyButton.setTitle("Copy", for: .normal)
        copyButton.setTitleColor(.white, for: .normal)
        copyButton.backgroundColor = UIColor(hexString: "#FFBE3F")
        copyButton.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 16)
        copyButton.semanticContentAttribute = .forceLeftToRight
        copyButton.addTarget(self, action: #selector(copyButtonClick(button:)), for: .touchUpInside)
        
        self.contentView.addSubview(copyButton)
        copyButton.snp.makeConstraints {
            $0.left.equalTo(editButton.snp.right).offset(8)
            $0.height.equalTo(48)
            $0.right.equalTo(-12)
            $0.centerY.equalTo(editButton)
        }
        
        cellLabel.textAlignment = .center
        cellLabel.textColor = .black
        cellLabel.numberOfLines = 0
        cellLabel.font = UIFont(name: "PingFangSC-Semibold", size: 16)
        self.contentView.addSubview(cellLabel)
        cellLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(10)
            make.bottom.equalTo(editButton.snp.top).offset(-10)
            make.right.equalTo(-20)
        }
    }
    
    @objc func editButtonClick(button: UIButton) {
        editButtonClickBlock?(self.tag)
    }
    
    @objc func copyButtonClick(button: UIButton) {
        copyButtonClickBlock?(self.tag)
    }
    
    func copyButtonStyel(tag: Int) {
        if tag < 2 {
            copyButton.setTitle("Copy", for: .normal)
            
        } else {
            copyButton.setTitle("Copy - \(FKbCoinMana.default.coinCostCount)Coins", for: .normal)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
