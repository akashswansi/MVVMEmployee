//
//  StoryBoardHelper.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 12/01/22.
//

import Foundation
import UIKit


/// Storyboard identifiers
enum AppClass: String {
    /// Storyboard instance for LoginPhoneVC
   case ListVC = "ListViewController"
}

/// Enum for Storyboard
enum StoryBoard: String {
    case Main
    /// Storyboard instance
    var board: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}
