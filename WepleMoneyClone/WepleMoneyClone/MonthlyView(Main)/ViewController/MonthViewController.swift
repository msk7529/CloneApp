//
//  MonthViewController.swift
//  WepleMoneyClone
//
//  Created by kakao on 2020/12/09.
//

import UIKit
import Foundation

final class MonthViewController: UIViewController {

    // MARK: - UIComponents
    
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
    
    lazy var seperlatorLine2: UIView = {
        let seperlatorLine: UIView = UIView(frame: .zero)
        seperlatorLine.translatesAutoresizingMaskIntoConstraints = false
        seperlatorLine.backgroundColor = UIColor(rgb: 0x3F3F3F)
        return seperlatorLine
    }()
    
    lazy var tableView: DailyHistoryInfoTableView = {
        let tableView: DailyHistoryInfoTableView = DailyHistoryInfoTableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset.left = 0   // 기본적으로 들어가있는 테이블뷰셀의 왼쪽 여백 없애기
        tableView.tableFooterView = UIView(frame: .zero)    // 빈 셀 안 보이게 처리
        return tableView
    }()
    
    lazy var plusButton: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plusButton"), for: .normal)
        button.addTarget(self, action: #selector(plusButtonDidTap), for: .touchUpInside)
        button.layer.shadowRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 0)
        button.layer.shadowOpacity = 0.2
        return button
    }()
    
    // MARK: - Components for paging
    
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
            vc.view.tag = index
            viewControllers.append(vc)
        }
        return viewControllers
    }()
    
    // MARK: - Properties
    
    private let today: Date = Date()
    private var todayYear: Int!
    private var todayMonth: Int!
    private var todayDay: Int!
    
    var expenseDAO: ExpenseDAO = ExpenseDAO()
    var incomeDAO: IncomeDAO = IncomeDAO()
    var calendarRootViewHeightConstraint: NSLayoutConstraint!   // calendarRootView의 높이조정을 위해 선언
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todayDay = Calendar.current.component(.day, from: today)
        todayMonth = Calendar.current.component(.month, from: today)
        todayYear = Calendar.current.component(.year, from: today)
        
        setNavigation()
        
        self.dayCollecionView.delegate = self
        self.dayCollecionView.dataSource = self
        self.dayCollecionView.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: DayCollectionViewCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(DailyHistoryInfoTableViewCell.self, forCellReuseIdentifier: DailyHistoryInfoTableViewCell.identifier)
        
        guard let monthCalendarVC = monthCalendarViewControllers.first else {
            return
        }
        monthCalendarVC.currentYear = todayYear
        monthCalendarVC.currentMonth = todayMonth
        monthCalendarVC.currentDay = todayDay
        monthCalendarVC.expenseInfoList = expenseDAO.fetch(yearMonth: "\(String(describing: todayYear!))\(String(format: "%02d", todayMonth))")
        monthCalendarVC.incomeInfoList = incomeDAO.fetch(yearMonth: "\(String(describing: todayYear!))\(String(format: "%02d", todayMonth))")
        
        monthCalendarVC.showDailyHistoryInfo = { [weak self] expenseInfoModel in
            // 캘린더뷰의 날짜를 터치했을때 실행되는 클로저. 테이블뷰를 갱신한다.
            guard let strongSelf = self else { return }
            
            strongSelf.tableView.expenseInfo = expenseInfoModel
            strongSelf.tableView.reloadData()
        }
        
        monthCalendarVC.reloadDailyHistoryInfoIfNeeded = { [weak self] expenseInfoModel in
            // 입금/지출내역을 등록한 뒤 실행되는 클로저. 테이블뷰를 갱신한다.
            guard let strongSelf = self else { return }
            
            strongSelf.tableView.expenseInfo = expenseInfoModel
            strongSelf.tableView.reloadData()
        }
        
        monthCalendarVC.showMonthlyIncomeExpenseMoney = { [weak self] totalExpense, totalCashExpense, totalCardExpense, totalIncome in
            // 월간 입금/지출금액, 현금잔액 표시
            guard let strongSelf = self else { return }
            
            strongSelf.expenseMoney.text = String(totalExpense) + "원"
            strongSelf.cashMoney.text = String(totalCashExpense) + "원"
            strongSelf.cardMoney.text = String(totalCardExpense) + "원"
            strongSelf.incomeMoney.text = String(totalIncome) + "원"
            strongSelf.balanceMoney.text = String(totalIncome - totalExpense) + "원"
        }
        
        calendarPageViewController.setViewControllers([monthCalendarVC], direction: .forward, animated: false, completion: nil)
        
        makeUI()
    }
    
    // MARK: - fuction
    
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
        self.view.addSubview(tableView)
        self.view.addSubview(plusButton)
        
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
        
        tableView.topAnchor.constraint(equalTo: self.seperlatorLine2.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        plusButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        plusButton.rightAnchor.constraint(equalTo: self.expenseMoney.rightAnchor).isActive = true
    }
    
    private func setNavigation() {
        let textAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        self.navigationItem.title = "\(String(describing: todayMonth!))월"
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x79BDB3)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes

        let leftBtn: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let rightBtn1: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let rightBtn2: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        leftBtn.setImage(UIImage(named: "statisticsIcon")?.withTintColor(.white), for: .normal)
        leftBtn.backgroundColor = .clear
        rightBtn1.setImage(UIImage(named: "filterIcon")?.withTintColor(.white), for: .normal)
        rightBtn1.backgroundColor = .clear
        rightBtn2.setImage(UIImage(named: "searchIcon")?.withTintColor(.white), for: .normal)
        rightBtn2.backgroundColor = .clear
        
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: leftBtn)
        let rightBarButtonItem1: UIBarButtonItem = UIBarButtonItem(customView: rightBtn1)
        let rightBarButtonItem2: UIBarButtonItem = UIBarButtonItem(customView: rightBtn2)
        
        leftBarButtonItem.target = self
        leftBarButtonItem.action = nil
        rightBarButtonItem1.target = self
        rightBarButtonItem1.action = nil
        rightBarButtonItem2.target = self
        rightBarButtonItem2.action = nil
        
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItems = [rightBarButtonItem1, rightBarButtonItem2]
    }
    
    func setNavigationTitle(currentYear: Int, currentMonth: Int) {
        if let todayYear = todayYear {
            if todayYear == currentYear {
                self.navigationItem.title = "\(currentMonth)월"
            } else {
                self.navigationItem.title = "\(currentYear)년 \(currentMonth)월"
            }
        }
    }
    
    @objc private func plusButtonDidTap() {
        if let addVC = self.storyboard?.instantiateViewController(identifier: "AddDealHistoryViewController") as? AddDealHistoryViewController {
            addVC.modalTransitionStyle = .coverVertical
            addVC.modalPresentationStyle = .fullScreen
        
            let selectedDate: Date = SingleTon.shared.selectedDate ?? Date()
            let year: Int = Calendar.current.component(.year, from: selectedDate)
            let month: Int = Calendar.current.component(.month, from: selectedDate)
            
            let dataModel: InfoModel = InfoModel()
            dataModel.date = selectedDate
            dataModel.yearMonth = "\(year)\(String(format: "%02d", month))"
            
            addVC.dataModel = dataModel
            
            self.present(addVC, animated: true, completion: nil)
        }
    }
    
    func beforeYearMonth(currentYear: Int, currentMonth: Int) -> (Int, Int) {
        return currentMonth == 1 ? (currentYear - 1 , 12) : (currentYear, currentMonth - 1)
    }
    
    func afterYearMonth(currentYear: Int, currentMonth: Int) -> (Int, Int) {
        return currentMonth == 12 ? (currentYear + 1, 1) : (currentYear, currentMonth + 1)
    }
}
