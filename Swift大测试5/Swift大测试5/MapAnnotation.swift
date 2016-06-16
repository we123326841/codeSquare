//
//  MapAnnotation.swift
//  Swift大测试5
//
//  Created by 王浩 on 16/4/11.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit
import MapKit
class MapAnnotation: NSObject,MKAnnotation {
    var _title:String?
    var _coordinate:CLLocationCoordinate2D
    init(title:String,coordinate:CLLocationCoordinate2D) {
       
       _title = title
        _coordinate = coordinate
    }
    
    
    var title: String?{
        set{
            _title = newValue
        }
        
        get{
            return _title
        }
    }
    
    var coordinate: CLLocationCoordinate2D{
        set{
            _coordinate = newValue
        }
        
        get{
            return _coordinate
        }

    
    }
//    var title: String?{
//        set{
//           print("色色的侧")
//                   }
//        // title = newValue 也是循环调用
//        get{
//            print("coordinate==\(self.title)")
//            //self.title 实际上在循环调用
//            return self.title
//        }
//    }
//    
//    var coordinate: CLLocationCoordinate2D{
//        set{
//            print("别管我")
//        }
//        
//        get{
//            print("coordinate==\(self.coordinate.latitude)")
//            return self.coordinate
//        }
//
//        
//        
//        
//    }

}
