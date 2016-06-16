//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let v = UIView(frame: CGRectMake(0,0,50,50))
v.backgroundColor = UIColor.redColor()
let btn = UIButton(type: UIButtonType.ContactAdd)
btn.center = v.center
v.addSubview(btn)
