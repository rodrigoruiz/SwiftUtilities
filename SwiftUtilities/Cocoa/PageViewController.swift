//
//  PageViewController.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 5/3/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

public class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    public var orderedViewControllers = [UIViewController]() {
        didSet {
            if self.orderedViewControllers.count == 0 {
                return
            }
            
            self.setViewControllers(
                [self.orderedViewControllers[0]],
                direction: .forward,
                animated: true,
                completion: nil
            )
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < orderedViewControllers.count else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
