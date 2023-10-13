//
//  MaterialShowCaseSequence.swift
//  MaterialShowcase
//
//  Created by VB on 16.04.2019.
//  Copyright © 2019 Aromajoin. All rights reserved.
//

import Foundation

@objc public class MaterialShowcaseSequence: NSObject {
    
    var showcaseArray : [MaterialShowcase] = []
    var currentCase : Int = 0
    var key : String?
    
    @objc public func temp(_ showcase: MaterialShowcase) -> MaterialShowcaseSequence {
        showcaseArray.append(showcase)
        return self
    }
    @objc public func start() {
        guard !getUserState(key: self.key) else {
            return
        }
        showcaseArray.first?.show(completion: increase)
    }
    func increase() -> Void {
        self.currentCase += 1
    }
    
    /// Set user show retry
    @objc public func setKey(key : String? = nil) -> MaterialShowcaseSequence {
        guard key != nil else {
            return self
        }
        self.key = key
        return self
    }
    
    /// Remove user state
    @objc public func removeUserState(key : String = MaterialKey._default.rawValue) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    /// Remove user state
    func getUserState(key : String?) -> Bool {
        guard key != nil else {
            return false
        }
        return UserDefaults.standard.bool(forKey: key!)
    }
    
    @objc public func showCaseWillDismis() {
        guard self.showcaseArray.count > currentCase else {
            //last index
            guard self.key != nil else {
                return
            }
            UserDefaults.standard.set(true, forKey: key!)
            return
        }
        showcaseArray[currentCase].show(completion: self.increase)
    }

       @objc public func cancelTour() {
        //   let temp = showcaseArray[self.currentCase]
        self.currentCase = showcaseArray.count+1
        showCaseWillDismis()
        //  temp.completeShowcase()
    }
    
}

