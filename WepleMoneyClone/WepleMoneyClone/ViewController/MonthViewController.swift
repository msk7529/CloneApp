//
//  MonthViewController.swift
//  WepleMoneyClone
//
//  Created by kakao on 2020/12/09.
//

import UIKit
import Foundation

final class MonthViewController: UIViewController {

    lazy var income: UILabel = {
        let income: UILabel = UILabel()
        income.text = "수입"
        income.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        income.textColor = .black
        income.translatesAutoresizingMaskIntoConstraints = false
        return income
    }()
    
    lazy var incomeMoney: UILabel = {
        let incomeMoney: UILabel = UILabel()
        incomeMoney.text = "0원"
        incomeMoney.font = UIFont.systemFont(ofSize: 23)
        incomeMoney.textColor = .systemGreen
        incomeMoney.textAlignment = .right
        incomeMoney.translatesAutoresizingMaskIntoConstraints = false
        return incomeMoney
    }()
    
    lazy var balance: UILabel = {
        let balance: UILabel = UILabel()
        balance.text = "현금 잔액"
        balance.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        balance.textColor = .black
        balance.translatesAutoresizingMaskIntoConstraints = false
        return balance
    }()
    
    lazy var balanceMoney: UILabel = {
        let balanceMoney: UILabel = UILabel()
        balanceMoney.text = "0원"
        balanceMoney.font = UIFont.systemFont(ofSize: 23)
        balanceMoney.textColor = .gray
        balanceMoney.textAlignment = .right
        balanceMoney.translatesAutoresizingMaskIntoConstraints = false
        return balanceMoney
    }()
    
    lazy var expense: UILabel = {
        let expense: UILabel = UILabel()
        expense.text = "지출"
        expense.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        expense.textColor = .black
        expense.translatesAutoresizingMaskIntoConstraints = false
        return expense
    }()
    
    lazy var expenseMoney: UILabel = {
        let expenseMoney: UILabel = UILabel()
        expenseMoney.text = "0원"
        expenseMoney.font = UIFont.systemFont(ofSize: 23)
        expenseMoney.textColor = .systemPink
        expenseMoney.textAlignment = .right
        expenseMoney.translatesAutoresizingMaskIntoConstraints = false
        return expenseMoney
    }()
    
    lazy var cash: UILabel = {
        let cash: UILabel = UILabel()
        cash.text = "현금"
        cash.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 3)
        cash.textColor = .lightGray
        cash.translatesAutoresizingMaskIntoConstraints = false
        return cash
    }()
    
    lazy var cashMoney: UILabel = {
        let cashMoney: UILabel = UILabel()
        cashMoney.text = "0"
        cashMoney.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 1)
        cashMoney.textColor = .lightGray
        cashMoney.textAlignment = .right
        cashMoney.translatesAutoresizingMaskIntoConstraints = false
        return cashMoney
    }()
    
    lazy var card: UILabel = {
        let card: UILabel = UILabel()
        card.text = "카드"
        card.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 3)
        card.textColor = .lightGray
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    lazy var cardMoney: UILabel = {
        let cardMoney: UILabel = UILabel()
        cardMoney.text = "0"
        cardMoney.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 1)
        cardMoney.textColor = .lightGray
        cardMoney.textAlignment = .right
        cardMoney.translatesAutoresizingMaskIntoConstraints = false
        return cardMoney
    }()
    
    lazy var mergeImage: UIImageView = {
        let mergeImage: UIImageView = UIImageView(image: UIImage(named: "image1"))
        mergeImage.translatesAutoresizingMaskIntoConstraints = false
        return mergeImage
    }()
    
    lazy var dayCollecionView: DayCollectionView = {
        let dayCollecionView: DayCollectionView = DayCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        // collectionViewLayout에 UICollectionViewLayout() 넣으면 cellForItemAt, UICollectionViewDelegateFlowLayout 동작 안함...
        dayCollecionView.backgroundColor = .clear
        dayCollecionView.translatesAutoresizingMaskIntoConstraints = false
        dayCollecionView.isScrollEnabled = false
        return dayCollecionView
    }()
    
    lazy var seperlatorLine: UIView = {
        let seperlatorLine: UIView = UIView(frame: .zero)
        seperlatorLine.translatesAutoresizingMaskIntoConstraints = false
        seperlatorLine.backgroundColor = .lightGray
        return seperlatorLine
    }()
    
    lazy var calendarRootView: UIView = {
        let calendarRootView: UIView = UIView(frame: .zero)
        calendarRootView.backgroundColor = .clear
        calendarRootView.translatesAutoresizingMaskIntoConstraints = false
        return calendarRootView
    }()
    
    lazy var calendarPageViewController: UIPageViewController = {
        let pageViewController: UIPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.view.backgroundColor = .clear
        
        calendarRootView.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.topAnchor.constraint(equalTo: calendarRootView.topAnchor).isActive = true
        pageViewController.view.leftAnchor.constraint(equalTo: calendarRootView.leftAnchor).isActive = true
        pageViewController.view.rightAnchor.constraint(equalTo: calendarRootView.rightAnchor).isActive = true
        pageViewController.view.bottomAnchor.constraint(equalTo: calendarRootView.bottomAnchor).isActive = true
        
        return pageViewController
    }()
    
    lazy var monthCalendarViewControllers: [MonthCalendarViewController] = {
        var viewControllers: [MonthCalendarViewController] = []
        
        for index in 0...2 {
            let vc: MonthCalendarViewController = MonthCalendarViewController()
            vc.todayYearMonth = (todayYear!, todayMonth!)
            vc.view.tag = index
            viewControllers.append(vc)
        }
        return viewControllers
    }()
    
    lazy var seperlatorLine2: UIView = {
        let seperlatorLine: UIView = UIView(frame: .zero)
        seperlatorLine.translatesAutoresizingMaskIntoConstraints = false
        seperlatorLine.backgroundColor = UIColor(rgb: 0x3F3F3F)
        return seperlatorLine
    }()
    
    private let today: Date = Date()
    private var todayYear: Int?
    private var todayMonth: Int?
    private var todayDay: Int?
    
    private var calendarRootViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        todayDay = Calendar.current.component(.day, from: today)
        todayMonth = Calendar.current.component(.month, from: today)
        todayYear = Calendar.current.component(.year, from: today)
        
        self.navigationItem.title = "\(String(describing: todayMonth!))월"
        
        self.dayCollecionView.delegate = self
        self.dayCollecionView.dataSource = self
        self.dayCollecionView.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: DayCollectionViewCell.identifier)
        
        guard let monthCalendarVC = monthCalendarViewControllers.first else {
            return
        }
        monthCalendarVC.currentYear = todayYear
        monthCalendarVC.currentMonth = todayMonth
        
        calendarPageViewController.setViewControllers([monthCalendarVC], direction: .forward, animated: false, completion: nil)
        
        makeUI()
    }
    
    private func makeUI() {
        self.view.addSubview(income)
        self.view.addSubview(balance)
        self.view.addSubview(incomeMoney)
        self.view.addSubview(balanceMoney)
        self.view.addSubview(expense)
        self.view.addSubview(expenseMoney)
        self.view.addSubview(cash)
        self.view.addSubview(cashMoney)
        self.view.addSubview(card)
        self.view.addSubview(cardMoney)
        self.view.addSubview(mergeImage)
        self.view.addSubview(dayCollecionView)
        self.view.addSubview(seperlatorLine)
        self.view.addSubview(calendarRootView)
        self.view.addSubview(seperlatorLine2)
        
        income.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        income.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        income.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        incomeMoney.topAnchor.constraint(equalTo: self.income.topAnchor, constant: -7).isActive = true
        incomeMoney.leftAnchor.constraint(equalTo: self.income.rightAnchor, constant: 5).isActive = true
        incomeMoney.widthAnchor.constraint(equalToConstant: 115).isActive = true
                
        balance.topAnchor.constraint(equalTo: self.income.bottomAnchor, constant: 20).isActive = true
        balance.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        balance.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        balanceMoney.topAnchor.constraint(equalTo: self.balance.topAnchor, constant: -7).isActive = true
        balanceMoney.leftAnchor.constraint(equalTo: self.balance.rightAnchor, constant: 5).isActive = true
        balanceMoney.widthAnchor.constraint(equalToConstant: 115).isActive = true
        
        expense.topAnchor.constraint(equalTo: self.income.topAnchor).isActive = true
        expense.leftAnchor.constraint(equalTo: self.incomeMoney.rightAnchor, constant: 15).isActive = true
        expense.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        expenseMoney.topAnchor.constraint(equalTo: self.incomeMoney.topAnchor).isActive = true
        expenseMoney.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        expenseMoney.widthAnchor.constraint(equalToConstant: 115).isActive = true
        
        cash.topAnchor.constraint(equalTo: self.expense.bottomAnchor, constant: 7).isActive = true
        cash.leftAnchor.constraint(equalTo: self.expense.leftAnchor, constant: 25).isActive = true
        cash.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        cashMoney.topAnchor.constraint(equalTo: self.cash.topAnchor, constant: -1).isActive = true
        cashMoney.rightAnchor.constraint(equalTo: self.expenseMoney.rightAnchor).isActive = true
        cashMoney.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        card.topAnchor.constraint(equalTo: self.cash.bottomAnchor, constant: 4).isActive = true
        card.leftAnchor.constraint(equalTo: self.cash.leftAnchor).isActive = true
        card.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        cardMoney.topAnchor.constraint(equalTo: self.card.topAnchor, constant: -1).isActive = true
        cardMoney.rightAnchor.constraint(equalTo: self.expenseMoney.rightAnchor).isActive = true
        cardMoney.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        mergeImage.topAnchor.constraint(equalTo: self.cash.centerYAnchor, constant: -2).isActive = true
        mergeImage.rightAnchor.constraint(equalTo: self.cash.leftAnchor, constant: -3).isActive = true
        mergeImage.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        dayCollecionView.topAnchor.constraint(equalTo: self.balanceMoney.bottomAnchor, constant: 9).isActive = true
        dayCollecionView.leftAnchor.constraint(equalTo: self.income.leftAnchor).isActive = true
        dayCollecionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        dayCollecionView.heightAnchor.constraint(equalToConstant: DayCollectionViewCell.height).isActive = true
        
        seperlatorLine.topAnchor.constraint(equalTo: self.dayCollecionView.bottomAnchor, constant: 2).isActive = true
        seperlatorLine.leftAnchor.constraint(equalTo: dayCollecionView.leftAnchor).isActive = true
        seperlatorLine.rightAnchor.constraint(equalTo: dayCollecionView.rightAnchor).isActive = true
        seperlatorLine.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        
        calendarRootView.topAnchor.constraint(equalTo: self.seperlatorLine.bottomAnchor, constant: 3).isActive = true
        calendarRootView.leftAnchor.constraint(equalTo: seperlatorLine.leftAnchor).isActive = true
        calendarRootView.rightAnchor.constraint(equalTo: seperlatorLine.rightAnchor).isActive = true
        if let currentCalendarVC =  calendarPageViewController.viewControllers?.first as? MonthCalendarViewController {
            let calendarView: MonthCalendarCollectionView = currentCalendarVC.calendarView
            calendarRootViewHeightConstraint = calendarRootView.heightAnchor.constraint(equalToConstant: MonthCalendarCollectionViewCell.height * CGFloat(calendarView.numOfRow))
            calendarRootViewHeightConstraint.isActive = true
        } else {
            calendarRootView.heightAnchor.constraint(equalToConstant: 300).isActive = true
            calendarRootView.backgroundColor = .red     // error
        }
        
        seperlatorLine2.topAnchor.constraint(equalTo: self.calendarRootView.bottomAnchor, constant: 7).isActive = true
        seperlatorLine2.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        seperlatorLine2.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        seperlatorLine2.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
    }
    
    private func beforeYearMonth(currentYear: Int, currentMonth: Int) -> (Int, Int) {
        var dateComponents: DateComponents = DateComponents()
        dateComponents.year = currentYear
        dateComponents.month = currentMonth
        dateComponents.day = 1
        dateComponents.timeZone = .current
        
        var calendar: Calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ko")
        
        guard let currentDate = calendar.date(from: dateComponents) else {
            print("Error occured in beforeYearMonth function")
            return (0, 0)
        }
        
        let currentMonthDatecomponents: DateComponents = calendar.dateComponents([.year, .month], from: currentDate)
        let currentMonthDate: Date = calendar.date(from: currentMonthDatecomponents)!
        
        let beforeMonth: Date = calendar.date(byAdding: .month, value: -1, to: currentMonthDate)!
        let beforeMonthDateComponents: DateComponents = calendar.dateComponents([.year, .month], from: beforeMonth)
        
        return (beforeMonthDateComponents.year!, beforeMonthDateComponents.month!)
    }
    
    private func afterYearMonth(currentYear: Int, currentMonth: Int) -> (Int, Int) {
        var dateComponents: DateComponents = DateComponents()
        dateComponents.year = currentYear
        dateComponents.month = currentMonth
        dateComponents.day = 1
        dateComponents.timeZone = .current
        
        var calendar: Calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ko")
        
        guard let currentDate = calendar.date(from: dateComponents) else {
            print("Error occured in beforeYearMonth function")
            return (0, 0)
        }
        
        let currentMonthDatecomponents: DateComponents = calendar.dateComponents([.year, .month], from: currentDate)
        let currentMonthDate: Date = calendar.date(from: currentMonthDatecomponents)!
        
        let afterMonth: Date = calendar.date(byAdding: .month, value: +1, to: currentMonthDate)!
        let afterMonthDateComponents: DateComponents = calendar.dateComponents([.year, .month], from: afterMonth)
        
        return (afterMonthDateComponents.year!, afterMonthDateComponents.month!)
    }
    
    private func setNavigationTitle(currentYear: Int, currentMonth: Int) {
        if let todayYear = todayYear {
            if todayYear == currentYear {
                self.navigationItem.title = "\(currentMonth)월"
            } else {
                self.navigationItem.title = "\(currentYear)년 \(currentMonth)월"
            }
        }
    }
}

extension MonthViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DayCollectionView.dayCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let collectionView = collectionView as? DayCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCollectionViewCell.identifier, for: indexPath) as? DayCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.day = DayCollectionView.daySringArr[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MonthViewController: UICollectionViewDelegate {
    
}

extension MonthViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀의 사이즈 정의
        return CGSize(width: collectionView.frame.width / 7, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 셀 간 세로간격 조정
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 셀 간 가로간격 조정
        return 0
    }
}

extension MonthViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let calendarVC = pageViewController.viewControllers?.first as? MonthCalendarViewController {
            let yearMonth: (Int, Int) = beforeYearMonth(currentYear: calendarVC.calendarView.currentYear, currentMonth: calendarVC.calendarView.currentMonth)
            let index: Int = calendarVC.view.tag
            let nextIndex: Int = index > 0 ? index - 1 : monthCalendarViewControllers.count - 1
            
            let beforeCalendarVC: MonthCalendarViewController = monthCalendarViewControllers[nextIndex]
            beforeCalendarVC.currentYear = yearMonth.0
            beforeCalendarVC.currentMonth = yearMonth.1
            
            return beforeCalendarVC
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let calendarVC = pageViewController.viewControllers?.first as? MonthCalendarViewController {
            let yearMonth: (Int, Int) = afterYearMonth(currentYear: calendarVC.calendarView.currentYear, currentMonth: calendarVC.calendarView.currentMonth)
            let index: Int = calendarVC.view.tag
            let nextIndex: Int = (index + 1) % monthCalendarViewControllers.count
            
            let afterCalendarVC: MonthCalendarViewController = monthCalendarViewControllers[nextIndex]
            afterCalendarVC.currentYear = yearMonth.0
            afterCalendarVC.currentMonth = yearMonth.1
            
            return afterCalendarVC
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished == true {
            if let appearedVC = pageViewController.viewControllers?.first as? MonthCalendarViewController {
                
                calendarRootViewHeightConstraint.constant =  MonthCalendarCollectionViewCell.height * CGFloat(appearedVC.calendarView.numOfRow)
                
                setNavigationTitle(currentYear: appearedVC.currentYear, currentMonth: appearedVC.currentMonth)
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pageViewController.view.isUserInteractionEnabled = false
        let delay: Double = 0.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            pageViewController.view.isUserInteractionEnabled = true
        }
    }
}
