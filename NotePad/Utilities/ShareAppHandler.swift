//
//  File.swift
//  NotePad
//
//  Created by mac on 09/04/2023.
//

import Foundation
import UIKit

struct ShareAppHandler {

    static func share(data:String) {
        let message = data
        let items = [message] as [Any]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
        UIApplication.rootViewController?.present(activityVC, animated: true, completion: nil)
    }

}
