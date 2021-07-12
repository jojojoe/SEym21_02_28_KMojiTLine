//
//  ListViewController.swift
//  FancyTextlineEmojiCapiton
//
//  Created by 薛忱 on 2021/6/7.
//

import UIKit
import SVProgressHUD

enum ListVCStyle: Int {
    case caption = 0
    case emoji
    case textLine
    case kaomoji
}

class ListViewController: UIViewController {
    
    var titleStr = ""
    var viewColor = UIColor.init(hexString: "#FFFFFF")
    
    let collectionCellID = "ListViewController"
    var collectionView: UICollectionView?
    
    var style: ListVCStyle = .caption
    
    var dataArray = [""]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(hexString: "#272423")
        
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
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 56, height: 198)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 10, left: 28, bottom: 10, right: 28)
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.collectionView?.backgroundColor = .clear
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.showsVerticalScrollIndicator = false
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: collectionCellID)
        self.view.addSubview(self.collectionView!)
        self.collectionView!.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp.bottom).offset(40)
            make.left.right.equalTo(0)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(0)
        }
        
        switch style {
        case .caption:
            self.dataArray = captionArray
            backBtnBgImgV.image = UIImage(named: "caption_back_background")
            bgOverLayerImgV.image = UIImage(named: "caption_background")
            topLabel.text = "Caption"
            
            break
            
        case .emoji:
            self.dataArray = emojiArray
            backBtnBgImgV.image = UIImage(named: "cuteemoji_back_background")
            bgOverLayerImgV.image = UIImage(named: "cuteemoji_background")
            topLabel.text = "CuteEmoji"
            break
            
        case .textLine:
            self.dataArray = textlineArray
            backBtnBgImgV.image = UIImage(named: "textlinei_back_background")
            bgOverLayerImgV.image = UIImage(named: "textline_background")
            topLabel.text = "Textline"
            
            break
        default:
            break
        }
    }
    
    @objc func backbuttonClick(button: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as? ListCollectionViewCell
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let myCell = cell as? ListCollectionViewCell
        myCell?.cellLabel.text = dataArray[indexPath.row]
        myCell?.tag = indexPath.row
        myCell?.copyButtonStyel(tag: indexPath.row)
        myCell?.copyButtonClickBlock = { tag in
            self.copy(tag: tag, contentText: self.dataArray[tag])
        }
        
        myCell?.editButtonClickBlock = { tag in
            DispatchQueue.main.async {
                let str = self.dataArray[indexPath.row]
                let editTextVC = EditTextViewController()
                editTextVC.modalPresentationStyle = .fullScreen
                editTextVC.contentLabel.text = str
                editTextVC.style = self.style
                editTextVC.needMoney = tag > 1
                self.navigationController?.pushViewController(editTextVC)
                 
            }
        }
        
        switch style {
        case .caption:
            myCell?.copyButton.backgroundColor = UIColor(hexString: "#7449AB")
            myCell?.editButton.layer.borderColor = UIColor(hexString: "#7449AB")?.cgColor
            myCell?.editButton.setTitleColor(UIColor(hexString: "#7449AB"), for: .normal)
             
            break
            
        case .emoji:
            myCell?.copyButton.backgroundColor = UIColor(hexString: "#22C2F4")
            myCell?.editButton.layer.borderColor = UIColor(hexString: "#22C2F4")?.cgColor
            myCell?.editButton.setTitleColor(UIColor(hexString: "#22C2F4"), for: .normal)
             
            break
            
        case .textLine:
            myCell?.copyButton.backgroundColor = UIColor(hexString: "#FFBE3F")
            myCell?.editButton.layer.borderColor = UIColor(hexString: "#FFBE3F")?.cgColor
            myCell?.editButton.setTitleColor(UIColor(hexString: "#FFBE3F"), for: .normal)
             
            break
            
        case .kaomoji:
            myCell?.copyButton.backgroundColor = UIColor(hexString: "#E84435")
            myCell?.editButton.layer.borderColor = UIColor(hexString: "#E84435")?.cgColor
            myCell?.editButton.setTitleColor(UIColor(hexString: "#E84435"), for: .normal)
            
            break
        }
        
    }
        
    func copy(tag: Int, contentText: String) {
        
        if tag > 1 {
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
}
