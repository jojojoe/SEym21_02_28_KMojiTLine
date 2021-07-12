//
//  KomojiViewController.swift
//  FancyTextlineEmojiCapiton
//
//  Created by 薛忱 on 2021/6/7.
//

import UIKit
import SVProgressHUD

class KomojiViewController: UIViewController {
    
    var titleStr = ""
    var viewColor = UIColor.init(hexString: "#272423")
    
    let collectionCellID = "Komoji_CollectionViewCell"
    var collectionView: UICollectionView?
    let pageControl = UIPageControl()
    var currentStr = komojiArray[0]
    var currentTagIndex = 0
    var currentCell = KomojiCollectionViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = viewColor
        // Do any additional setup after loading the view.
         
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
        
        let nameTitleLabel = UILabel()
        view.addSubview(nameTitleLabel)
        nameTitleLabel.font = UIFont(name: "Verdana-Bold", size: 24)
        nameTitleLabel.textColor = UIColor(hexString: "#FFFFFF")
        nameTitleLabel.text = "Kaomoji"
        view.addSubview(nameTitleLabel)
        nameTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(backButton)
            $0.centerX.equalToSuperview()
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
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
        
        let bgOverLayerImgV = UIImageView(image: UIImage(named: "kaomoji_background"))
        bgOverLayerImgV.contentMode = .scaleAspectFill
        view.addSubview(bgOverLayerImgV)
        bgOverLayerImgV.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.width * (986/750))
            
        }

        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 56, height: 450)
//        layout.minimumLineSpacing = 56
//        layout.minimumInteritemSpacing = 56
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 28, bottom: 10, right: 28)
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.collectionView?.isPagingEnabled = true
        self.collectionView?.backgroundColor = .clear
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.showsVerticalScrollIndicator = false
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.register(KomojiCollectionViewCell.self, forCellWithReuseIdentifier: collectionCellID)
        self.view.addSubview(self.collectionView!)
        self.collectionView!.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(56)
            $0.left.right.equalTo(0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-120)
        }
        
        
        
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
            $0.centerY.equalTo(collectionView!.snp.top)
            $0.centerX.equalToSuperview()
        }
        
        //
        pageControl.numberOfPages = komojiArray.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.init(hexString: "#FFFFFF", transparency: 0.3)
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.addTarget(self, action: #selector(pageControlClick(pageControl:)), for: .valueChanged)
        self.view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.height.equalTo(20)
            make.top.equalTo(collectionView!.snp.bottom).offset(20)
        }
    }
    
    @objc func pageControlClick(pageControl: UIPageControl) {
        let page: Int? = pageControl.currentPage
        self.collectionView?.contentOffset = CGPoint(x: (page ?? 0) * Int(UIScreen.main.bounds.width), y: 0)
    }
    
    @objc func randomButtonClick(button: UIButton) {
        let randomValue = Int(arc4random()) % komojiArray.count

        let offset = randomValue == 0 ? 0 : randomValue - 1
        self.collectionView?.contentOffset = CGPoint(x: offset * Int(UIScreen.main.bounds.width), y: 0)
    }
    
    @objc func sharebuttonClick(button: UIButton) {
        
        currentCell.editButton.isHidden = true
        currentCell.copyButton.isHidden = true
        currentCell.contetnBgView.layer.cornerRadius = 0
        let imageV = currentCell.contetnBgView.changeToImage()
        currentCell.editButton.isHidden = false
        currentCell.copyButton.isHidden = false
        currentCell.contetnBgView.layer.cornerRadius = 20
        let activityItems = [imageV] as [Any]
        let toVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        present(toVC, animated: true, completion: nil)
        toVC.completionWithItemsHandler = {[weak self] activityType, completed, returnedItems, activityError in
            guard let `self` = self else {return}
            if activityType == .copyToPasteboard {
                self.copy(tag: self.currentTagIndex, contentText: komojiArray[ self.currentTagIndex])
            } else {
                let alert = UIAlertController(title: "", message: completed ? "Share Success" : "Share Fail", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default) { (action) in
                }
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            
//            let alert = UIAlertController(title: "", message: completed ? "Share Success" : "Share Fail", preferredStyle: .alert)
//            let okButton = UIAlertAction(title: "OK", style: .default) { (action) in
//            }
//            alert.addAction(okButton)
//            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    @objc func backbuttonClick(button: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
  
}

 
extension KomojiViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.width, height: collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
 

extension KomojiViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return komojiArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as? KomojiCollectionViewCell
        
        return cell ?? UICollectionViewCell()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let myCell = cell as? KomojiCollectionViewCell
        myCell?.tag = indexPath.row
        myCell?.cellLabel.text = komojiArray[indexPath.row]
        
        
        
        currentStr = komojiArray[indexPath.row]
        currentTagIndex = indexPath.row
        
        myCell?.copyButtonStyel(tag: indexPath.row)
        myCell?.copyButtonClickBlock = { tag in
            self.copy(tag: tag, contentText: komojiArray[tag])
        }
        
        myCell?.editButtonClickBlock = { tag in
                        
            DispatchQueue.main.async {
                let str = komojiArray[indexPath.row]
                let editTextVC = EditTextViewController()
                editTextVC.modalPresentationStyle = .fullScreen
                editTextVC.contentLabel.text = str
                editTextVC.style = .kaomoji
                editTextVC.needMoney = tag > 1
                self.navigationController?.pushViewController(editTextVC)
                 
            }
        }
        
        currentCell = myCell ?? KomojiCollectionViewCell()
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / UIScreen.main.bounds.width
        self.pageControl.currentPage = Int(page)
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
