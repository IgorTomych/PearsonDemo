//
//  MainViewController.swift
//  Pearson
//
//  Created by Denys Trush on 11/10/17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    var courses: [Course] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showHUD()

        _ = APIClient.shared.getUser { (userProfile, error) in
            if let er = error {
                self.hideHUD()
                self.handleError(error: er)
            } else {
                guard let profile = userProfile, let user = profile.user else {
                    return
                }
                User.setCurrentUser(user: user)
                
                self.getCourses(completion: { (loadedCourses, error) in
                    self.hideHUD()
                    guard let loaded = loadedCourses else {
                        return
                    }
                    self.courses = loaded
                })
            }
        }
    }
    
    func getCourses(completion: @escaping ([Course]?, Error?) -> Void) {
        guard let school = User.current().getMainSchool() else {
            return
        }
        
        _ = APIClient.shared.getCourses(schoolId: school.schoolId, completion: completion)
    }
    
    // MARK: UICollectViewDatasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseIdentifier", for: indexPath) as! CourseCollectionViewCell
        let course = courses[indexPath.row]
        
        cell.configure(course: course)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController.pendingAlert()
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
        
        return CGSize(width: collectionView.frame.width - insets.right - insets.left, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
