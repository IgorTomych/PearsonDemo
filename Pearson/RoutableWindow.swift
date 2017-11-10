//
//  RoutableWindow.swift
//  Pearson
//
//  Created by Denys Trush on 11/10/17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import UIKit

class RoutableWindow: UIWindow {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if APIClient.shared.pearsonClient.isAuthenticated {
            self.showMain()
        } else {
            self.showAuth()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showMain() {
        let rootVC = UIStoryboard.main().instantiateInitialViewController()
        self.rootViewController = rootVC
    }
    
    func showAuth() {
        let rootVC = UIStoryboard.auth().instantiateInitialViewController()
        self.rootViewController = rootVC
    }
}
