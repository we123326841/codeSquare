//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty:Int {
        return 3
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty:Int {
        return 6
    }
    

}

class SomeClass {
    static var storedTypeProperty = "Some value."
    
    static var computedTypeProperty:Int {
        return 27
    }
    class var overrideableComputedTypeProperty:Int{
        return 107
    }


}

print(SomeStructure.storedTypeProperty)
print(SomeStructure.computedTypeProperty)


print(SomeEnumeration.storedTypeProperty)
print(SomeEnumeration.computedTypeProperty)

print(SomeClass.storedTypeProperty)
print(SomeClass.computedTypeProperty)
print(SomeClass.overrideableComputedTypeProperty)











protocol FullyNamed {
    var fullName: String { get }
}





struct Person: FullyNamed {
   // var fullName: String
    var fullName: String
}
var john = Person(fullName: "John Appleseed")
class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
        self.fullName = "dede"
    }
//    var fullName: String {
//    return "得得得"
//        //(prefix ? prefix!+ " " :"")+ name
//    }
    
    var fullName: String
}
var ncc1701 = Starship(name: "Enterprise",prefix: "USS")


john.fullName = "得得"
ncc1701.fullName = "为份额违法"
