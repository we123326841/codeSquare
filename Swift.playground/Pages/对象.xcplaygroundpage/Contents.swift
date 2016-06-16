//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
class Person {

}


class  Student: Person {
    
}

class Women: Person {
    
}

let s = Student()
let a = s as! Person

print(a)

let b:Person = Student()
     let f  = b as! Student
f

let cc = Women()

let t  = cc as? Student

        