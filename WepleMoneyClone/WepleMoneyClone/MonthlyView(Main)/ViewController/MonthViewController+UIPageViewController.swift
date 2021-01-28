//
//  MonthViewController+UIPageViewController.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/04.
//
import UIKit

extension MonthViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let calendarVC = pageViewController.viewControllers?.first as? MonthCalendarViewController {
            let yearMonth: (Int, Int) = beforeYearMonth(currentYear: calendarVC.calendarView.currentYear, currentMonth: calendarVC.calendarView.currentMonth)
            let index: Int = calendarVC.view.tag
            let nextIndex: Int = index > 0 ? index - 1 : monthCalendarViewControllers.count - 1
            
            let beforeCalendarVC: MonthCalendarViewController = monthCalendarViewControllers[nextIndex]
            beforeCalendarVC.currentYear = yearMonth.0
            beforeCalendarVC.currentMonth = yearMonth.1
            beforeCalendarVC.expenseInfoList = expenseDAO.fetch(yearMonth: "\(yearMonth.0)\(String(format: "%02d", yearMonth.1))")
            
            beforeCalendarVC.showDailyHistoryInfo = { [weak self] expenseInfoModel, incomeInfoModel in
                // 캘린더뷰의 날짜를 터치했을때 실행되는 클로저. 테이블뷰를 갱신한다.
                guard let strongSelf = self else { return }
                
                strongSelf.tableView.expenseInfo = expenseInfoModel
                strongSelf.tableView.incomeInfo = incomeInfoModel
                strongSelf.tableView.reloadData()
            }
            
            beforeCalendarVC.showMonthlyIncomeExpenseMoney = { [weak self] totalExpense, totalCashExpense, totalCardExpense, totalIncome in
                // 월간 입금/지출금액 표시
                guard let strongSelf = self else { return }
                
                strongSelf.expenseMoney.text = String(totalExpense) + "원"
                strongSelf.cashMoney.text = String(totalCashExpense) + "원"
                strongSelf.cardMoney.text = String(totalCardExpense) + "원"
                strongSelf.incomeMoney.text = String(totalIncome) + "원"
                strongSelf.balanceMoney.text = String(totalIncome - totalExpense) + "원"
            }
            
            beforeCalendarVC.goPreviousPage = { [weak self] targetYear, targetMonth in
                guard let strongSelf = self else { return }
                
                let expenseInfoModel: [ExpenseInfoModel] = strongSelf.expenseDAO.fetchAtCertainDate(date: SingleTon.shared.selectedDate ?? Date())
                let incomeInfoModel: [IncomeInfoModel] = strongSelf.incomeDAO.fetchAtCertainDate(date: SingleTon.shared.selectedDate ?? Date())
                
                strongSelf.goToPreviousPage()
                strongSelf.setNavigation(currentYear: targetYear, currentMonth: targetMonth)
                strongSelf.tableView.expenseInfo = expenseInfoModel
                strongSelf.tableView.incomeInfo = incomeInfoModel
                strongSelf.tableView.reloadData()
            }
            
            beforeCalendarVC.goNextPage = { [weak self] targetYear, targetMonth in
                guard let strongSelf = self else { return }
                
                let expenseInfoModel: [ExpenseInfoModel] = strongSelf.expenseDAO.fetchAtCertainDate(date: SingleTon.shared.selectedDate ?? Date())
                let incomeInfoModel: [IncomeInfoModel] = strongSelf.incomeDAO.fetchAtCertainDate(date: SingleTon.shared.selectedDate ?? Date())
                
                strongSelf.goToNextPage()
                strongSelf.setNavigation(currentYear: targetYear, currentMonth: targetMonth)
                strongSelf.tableView.expenseInfo = expenseInfoModel
                strongSelf.tableView.incomeInfo = incomeInfoModel
                strongSelf.tableView.reloadData()
            }

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
            afterCalendarVC.expenseInfoList = expenseDAO.fetch(yearMonth: "\(yearMonth.0)\(String(format: "%02d", yearMonth.1))")
            
            afterCalendarVC.showDailyHistoryInfo = { [weak self] expenseInfoModel, incomeInfoModel in
                // 캘린더뷰의 날짜를 터치했을때 실행되는 클로저. 테이블뷰를 갱신한다.
                guard let strongSelf = self else { return }
                
                strongSelf.tableView.expenseInfo = expenseInfoModel
                strongSelf.tableView.incomeInfo = incomeInfoModel
                strongSelf.tableView.reloadData()
            }
            
            afterCalendarVC.showMonthlyIncomeExpenseMoney = { [weak self] totalExpense, totalCashExpense, totalCardExpense, totalIncome in
                // 월간 입금/지출금액 표시
                guard let strongSelf = self else { return }
                
                strongSelf.expenseMoney.text = String(totalExpense) + "원"
                strongSelf.cashMoney.text = String(totalCashExpense) + "원"
                strongSelf.cardMoney.text = String(totalCardExpense) + "원"
                strongSelf.incomeMoney.text = String(totalIncome) + "원"
                strongSelf.balanceMoney.text = String(totalIncome - totalExpense) + "원"
            }
            
            afterCalendarVC.goPreviousPage = { [weak self] targetYear, targetMonth in
                guard let strongSelf = self else { return }
                
                let expenseInfoModel: [ExpenseInfoModel] = strongSelf.expenseDAO.fetchAtCertainDate(date: SingleTon.shared.selectedDate ?? Date())
                let incomeInfoModel: [IncomeInfoModel] = strongSelf.incomeDAO.fetchAtCertainDate(date: SingleTon.shared.selectedDate ?? Date())
                
                strongSelf.goToPreviousPage()
                strongSelf.setNavigation(currentYear: targetYear, currentMonth: targetMonth)
                strongSelf.tableView.expenseInfo = expenseInfoModel
                strongSelf.tableView.incomeInfo = incomeInfoModel
                strongSelf.tableView.reloadData()
            }
            
            afterCalendarVC.goNextPage = { [weak self] targetYear, targetMonth in
                guard let strongSelf = self else { return }
                
                let expenseInfoModel: [ExpenseInfoModel] = strongSelf.expenseDAO.fetchAtCertainDate(date: SingleTon.shared.selectedDate ?? Date())
                let incomeInfoModel: [IncomeInfoModel] = strongSelf.incomeDAO.fetchAtCertainDate(date: SingleTon.shared.selectedDate ?? Date())
                
                strongSelf.goToNextPage()
                strongSelf.setNavigation(currentYear: targetYear, currentMonth: targetMonth)
                strongSelf.tableView.expenseInfo = expenseInfoModel
                strongSelf.tableView.incomeInfo = incomeInfoModel
                strongSelf.tableView.reloadData()
            }
            
            return afterCalendarVC
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed == true {
            // 화면전환이 완료되면 calendarRootView 높이 및 navi 셋팅
            if let appearedVC = pageViewController.viewControllers?.first as? MonthCalendarViewController {
                
                calendarRootViewHeightConstraint.constant = MonthCalendarCollectionViewCell.height * CGFloat(appearedVC.calendarView.numOfRow)
                
                guard let year = appearedVC.currentYear, let month = appearedVC.currentMonth else {
                    print("Error occured in setNavigationTitle")
                    return
                }
                
                self.currentYear = year
                self.currentMonth = month
                setNavigationTitle(currentYear: year, currentMonth: month)
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        // 빠른 swipe 방지
        pageViewController.view.isUserInteractionEnabled = false
        let delay: Double = 0.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            pageViewController.view.isUserInteractionEnabled = true
        }
    }
    
    func goToNextPage() {
        guard let currentVC = self.monthCalendarViewControllers.first else { return }
        
        if let nextVC = self.calendarPageViewController.dataSource?.pageViewController(self.calendarPageViewController, viewControllerAfter: currentVC) as? MonthCalendarViewController {
            self.calendarPageViewController.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
            calendarRootViewHeightConstraint.constant = MonthCalendarCollectionViewCell.height * CGFloat(nextVC.calendarView.numOfRow)
        }
    }
    
    func goToPreviousPage() {
        guard let currentVC = self.monthCalendarViewControllers.first else { return }
        
        if let previousVC = self.calendarPageViewController.dataSource?.pageViewController(self.calendarPageViewController, viewControllerBefore: currentVC) as? MonthCalendarViewController {
            self.calendarPageViewController.setViewControllers([previousVC], direction: .reverse, animated: true, completion: nil)
            calendarRootViewHeightConstraint.constant = MonthCalendarCollectionViewCell.height * CGFloat(previousVC.calendarView.numOfRow)
        }
    }
}
