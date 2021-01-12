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
            
            beforeCalendarVC.showDailyHistoryInfo = { [weak self] expenseInfoModel in
                // 캘린더뷰의 날짜를 터치했을때 실행되는 클로저. 테이블뷰를 갱신한다.
                guard let strongSelf = self else { return }
                
                strongSelf.tableView.expenseInfo = expenseInfoModel
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
            
            afterCalendarVC.showDailyHistoryInfo = { [weak self] expenseInfoModel in
                // 캘린더뷰의 날짜를 터치했을때 실행되는 클로저. 테이블뷰를 갱신한다.
                guard let strongSelf = self else { return }
                
                strongSelf.tableView.expenseInfo = expenseInfoModel
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
}
