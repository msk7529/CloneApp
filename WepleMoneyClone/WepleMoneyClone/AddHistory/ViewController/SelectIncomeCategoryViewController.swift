//
//  SelectIncomeCategoryViewController.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/13.
//

import UIKit

final class SelectIncomeCategoryViewController: UIViewController {

    lazy var backButton: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.setImage(UIImage(named: "backButton"), for: .highlighted)
        button.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel: UILabel = UILabel()
        moneyLabel.text = "0원"
        moneyLabel.font = UIFont.systemFont(ofSize: 23)
        moneyLabel.textColor = .systemGreen
        moneyLabel.textAlignment = .left
        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        return moneyLabel
    }()
    
    lazy var closeButton: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    lazy var InfoTextFiled: UITextField = {
        let InfoTextFiled: UITextField = UITextField(frame: .zero)
        InfoTextFiled.translatesAutoresizingMaskIntoConstraints = false
        InfoTextFiled.borderStyle = .none
        InfoTextFiled.textColor = .systemGray
        InfoTextFiled.font = UIFont.systemFont(ofSize: 23)
        InfoTextFiled.textAlignment = .left
        InfoTextFiled.keyboardType = .default
        InfoTextFiled.placeholder = "내역"
        InfoTextFiled.becomeFirstResponder()
        return InfoTextFiled
    }()
    
    lazy var incomeCategoryCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let incomeCategoryCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        incomeCategoryCollectionView.backgroundColor = .clear
        incomeCategoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        incomeCategoryCollectionView.isScrollEnabled = true
        incomeCategoryCollectionView.showsHorizontalScrollIndicator = false    // 스크롤바 안보이게 처리
        return incomeCategoryCollectionView
    }()
    
    var dataModel: ExpenseInfoModel? {
        didSet {
            moneyLabel.text = String(dataModel?.price ?? 0) + "원"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        incomeCategoryCollectionView.delegate = self
        incomeCategoryCollectionView.dataSource = self
        self.incomeCategoryCollectionView.register(IncomeCategoryCollectionViewCell.self, forCellWithReuseIdentifier: IncomeCategoryCollectionViewCell.identifier)
        
        makeUI()
    }
    
    override func viewDidLayoutSubviews() {
        // Layer 추가는 레이아웃에 걸린 addSubview 같은 것들이 모두 완료된 후에 호출되어야한다. lazy 프로퍼티 초기화시나 makeUI에서 추가해주면 노출 안됨.
        let border: CALayer = CALayer()
        border.frame = CGRect(x: 0, y: InfoTextFiled.frame.size.height-1, width: InfoTextFiled.frame.width, height: 1)
        border.backgroundColor = UIColor.systemGray.cgColor
        InfoTextFiled.layer.addSublayer(border)
    }

    private func makeUI() {
        self.view.addSubview(backButton)
        self.view.addSubview(moneyLabel)
        self.view.addSubview(closeButton)
        self.view.addSubview(InfoTextFiled)
        self.view.addSubview(incomeCategoryCollectionView)
        
        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        backButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        
        moneyLabel.topAnchor.constraint(equalTo: backButton.topAnchor, constant: -3).isActive = true
        moneyLabel.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 27).isActive = true
        
        closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        closeButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        InfoTextFiled.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 15).isActive = true
        InfoTextFiled.leftAnchor.constraint(equalTo: self.backButton.leftAnchor, constant: 3).isActive = true
        InfoTextFiled.rightAnchor.constraint(equalTo: self.closeButton.rightAnchor, constant: 0).isActive = true
        InfoTextFiled.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        incomeCategoryCollectionView.topAnchor.constraint(equalTo: self.InfoTextFiled.bottomAnchor, constant: 15).isActive = true
        incomeCategoryCollectionView.leftAnchor.constraint(equalTo: InfoTextFiled.leftAnchor).isActive = true
        incomeCategoryCollectionView.rightAnchor.constraint(equalTo: InfoTextFiled.rightAnchor).isActive = true
        incomeCategoryCollectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: ExpenseCategoryCollectionViewCell.height * CGFloat(IncomeCategory.category.count) + 30).isActive = true
    }
    
    @objc private func backButtonDidTap() {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
                
        self.dismiss(animated: false)
    }
    
    @objc func closeButtonDidTap() {
        var currentVC: UIViewController? = self     // 현재 뷰컨
        
        while(currentVC != nil) {
            let tmpVC: UIViewController? = currentVC?.presentingViewController  // 현재 뷰컨을 present시킨 뷰컨
            
            if(tmpVC?.presentedViewController == nil) {     // tmpVC에 의해 present 되어진 뷰컨
                currentVC?.dismiss(animated: true, completion: nil)
                break
            }
            currentVC = tmpVC
        }
    }
    


}
