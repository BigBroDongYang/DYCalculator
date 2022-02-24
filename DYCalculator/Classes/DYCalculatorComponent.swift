//
//  DYCalculatorComponent.swift
//  DYCalculator_Example
//
//  Created by 3erfdsxf on 2022/2/24.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

let SCREENWIDTH = UIScreen.main.bounds.width
let SCREENHEIGHT = UIScreen.main.bounds.height
let SAFEAREABOTTOM = UIScreen.main.bounds.height <= 736 ? 0 : -34
let ITEMWIDTH = (UIScreen.main.bounds.width-100)/4
let SPACE = 20.0

public class DYCC: UIView, UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    private let dataArr = ["AC", "+/-", "%", "+", "1", "2", "3", "-", "4", "5", "6", "*", "7", "8", "9", "/", "0", ".", "="]
    
    private lazy var resLabel:UILabel = {
        let resLabel = UILabel.init()
        resLabel.backgroundColor = .clear
        resLabel.textColor = .white
        resLabel.textAlignment = .right
        resLabel.font = .systemFont(ofSize: 100)
        resLabel.adjustsFontSizeToFitWidth = true
        resLabel.text = "0"
        return resLabel
    }()
    
    private lazy var collectView:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: ITEMWIDTH ,height: ITEMWIDTH)
        layout.minimumLineSpacing = SPACE
        layout.minimumInteritemSpacing = SPACE
        let collectView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        collectView.backgroundColor = .clear
        collectView.delegate = self
        collectView.dataSource = self
        collectView.showsVerticalScrollIndicator = true
        return collectView
    }()
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 16 {
            return CGSize(width: ITEMWIDTH*2+SPACE ,height: ITEMWIDTH)
        }
        return CGSize(width: ITEMWIDTH ,height: ITEMWIDTH)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ccCell
        cell.highlight(ispush: true)
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ccCell
        cell.highlight(ispush: false)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "ccCell" + String(format: "%@", indexPath as CVarArg)
        collectionView.register(ccCell.self, forCellWithReuseIdentifier: identifier)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ccCell
        cell.showtext(t: dataArr[indexPath.row])
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ccCell
        mathLogic(mark: cell.pushMark())
    }
    
    private func mathLogic(mark:String) {
        print(mark)
//        let res = resLabel.text
        
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        UI()
    }
    
    private func UI() {
        self.backgroundColor = .black
        self.addSubview(self.collectView)
        self.addSubview(self.resLabel)
        self.collectView.snp.makeConstraints { make in
            if SAFEAREABOTTOM == 0 {
                make.bottom.equalTo(self).offset(-SPACE)
            }else {
                make.bottom.equalTo(self).offset(SAFEAREABOTTOM)
            }
            
            make.left.equalTo(self).offset(SPACE)
            make.width.equalTo(self).offset(-SPACE*2)
            make.height.equalTo(SPACE*4+ITEMWIDTH*5)
        }
        self.resLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(SPACE)
            make.bottom.equalTo(self.collectView.snp_top).offset(-SPACE)
            make.width.equalTo(SCREENWIDTH-SPACE*2)
            make.height.equalTo(120)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class ccCell:UICollectionViewCell {
    
    private lazy var btnLable:UILabel = {
        let btnLable = UILabel.init()
        btnLable.backgroundColor = .orange
        btnLable.font = .systemFont(ofSize: 35)
        btnLable.textAlignment = .center
        btnLable.textColor = .white
        return btnLable
    }()
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        UI()
    }
    
    func UI(){
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(self.btnLable)
        self.btnLable.snp.makeConstraints { make in
            make.center.width.height.equalTo(self)
    
        }
        self.btnLable.layer.cornerRadius = self.contentView.frame.size.height/2
        self.btnLable.layer.masksToBounds = true
        self.btnLable.layer.borderWidth = 1
        self.btnLable.layer.borderColor = UIColor.clear.cgColor
        self.btnLable.alpha = 0.9
    }
    
    public func showtext (t:String){
        self.btnLable.layer.borderColor = UIColor.clear.cgColor
        self.btnLable.text = t
        if t == "AC" || t == "+/-" || t == "%" {
            self.btnLable.backgroundColor = .lightGray
        }else if t == "1" || t == "2" || t == "3" || t == "4" || t == "5" || t == "6" || t == "7" || t == "8" || t == "9" || t == "0" || t == "." {
            self.btnLable.backgroundColor = .darkGray
        }
    }
    
    public func highlight(ispush:Bool) {
        self.btnLable.alpha = 1.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.btnLable.alpha = 0.9
        }
        
    }
    
    public func pushMark()->String {
        highlight(ispush: true)
        return self.btnLable.text!
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
