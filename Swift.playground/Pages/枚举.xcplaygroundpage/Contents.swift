//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
enum CompassPoint {
    case North,Xixi
//    case South
//    case East
//    case West
}

var a = CompassPoint.North

a = .North

switch a {
case .North:
    print(".North")
//case .South:
//    print(".South")
//case .East: break
case .Xixi:
    print(".Xixi")
default:
    print("默认")
}


enum Barcode {
    case UPCA(Int,Int,Int,Int)
    case QRCode(String)
}

var productBarcode = Barcode.UPCA(9, 897, 21, 1)

//productBarcode = .QRCode("HDEHKJMSNACBEYRYWIIIXA")

switch productBarcode {
case .UPCA(let a ,let b ,let c , let d):
    print("\(a),,,\(b),,,\(c),,,\(d)")
case .QRCode(let a):
    print(a)

}







