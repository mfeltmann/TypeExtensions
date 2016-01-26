/*: tl;dr: Introduce this playground and eleminate any expectations according extensions or categories
# Extension Possibilities of Data Structures
For this playground we assume that all the things we can do with plain ```Swift``` objects can be done with plain ```Objective-C``` objects as well. We are not going to hazzle with funny or cryptic ```Objective-C``` runtime voodoo (reverenced as ```ObjCRV``` later on) since this would shift the problem to another sphere instead of solving it.

## Extensions/Categories
Nice try. But ```Objective-C``` warns you about overriding an existing method in a category and you'll find yourself unable to reach the default implementation. Well, unless you do some cryptic ```ObjCRV```.

In addition ```Swift``` forbids you to override existing functionality as mentioned in *The Swift Programming Language (Swift 2.2 Prerelease)* by **Apple Inc.**

> Extensions *can add **new functionality*** to a type, but they *cannot **override existing functionality***

So, no luck here.
*/
/*: tl;dr: Preface for subclassing
## Subclassing
I really don't like this option though we are in an **object-orientated** programming language. Why I don't like it, you ask? Well, sub*class*ing means we need *class*es. 

That's fine for programming languages like ```Java, Objective-C, C++, C#, Swift``` and so on. Languages, which are **class-based** or **class-orientated**.

But it is not working for programming languages that are **prototype-based** like ```JavaScript``` or **protocol-based** like ```Swift```.

So it is merely a ***class-orientated* solution** but not ***object-oriented* solution**. I really like ***object-oriented* solution**s, so I don't like this solution. That's why.
### Wait a sec, you mentioned ```Swift``` twice!
Yeah, I know. ```Swift``` indeed **is** class-based and **shall be used** protocol-based. So subclassing works for ```Swift``` when working with **classes** and does not work for ```Swift```when working with protocol-driven **structs** or **enums**.
*/
//: ### Defining The ```Parent``` Classes

class Foo {

	internal var title: String = "Meow"

	internal func qux(text: String) ->String {

		title = text

		print( "Foo qux': \(title)!" )
		return "Foo"
	}
}

let foo = Foo()
foo.qux("Hallo")

//: ### Defining The Subclasses

class FooBar : Foo {

	override func qux(text: String) -> String {

		super.qux(text)
		print( "Bar qux': \(title)!" )
		return "Bar"
	}
}

let foobar = FooBar()
foobar.qux("Moin")

class FooBaz : Foo {

	override func qux(text: String) -> String {

		super.qux(text)
		print( "Baz qux': \(title)!" )
		return "Baz"
	}
}

let foobaz = FooBaz()
foobaz.qux("Tach")

/*: Chapter Conclusion
### Conclusion
Combine 'em all together for getting an output like the following is impossible via subclassing.

    Foo qux: Tach!
    Bar qux: Tach!
    Baz qux: Tach!

Multiple inheritance would solve this problem but there are some flaws.

1. Multiple inheritance is the wrong approach because the objects don't just use this function but extend it with their own behaviour. Think about an amphibious vehicle. It drives like a car and swims like a boat, but in its completeness it's neither similar to a car nor to a boat.
1. Multiple inheritance is unsupported by each of the languages mentioned above.

*/
/*: tl;dr: Preface for Protocols
## Protocols
*Protocol*s exist in both ```Objective-C``` and ```Swift``` and are known as *interface*s to ```Java``` or ```C#``` developers as well.

### Defining The Protocol
*/
protocol Quxable {

	mutating func qux( text:String ) -> String
}

//: ### Defining The Structs
struct QuaxableFoo : Quxable {

	var title: String

	mutating func qux(text: String) -> String {

		title = text
		print( "Foo qux': \(self.title)!" )
		return "Foo"
	}
}

var quxableFoo = QuaxableFoo( title: "Meow" )
quxableFoo.qux( "Servas" )

struct QuaxableBar : Quxable {

	var title: String

	mutating func qux(text: String) -> String {

		title = text
		print( "Bar qux': \(self.title)!" )
		return "Bar"
	}
}
/*: Chapter Conclusion
### Conclusion
Obviously it is impossible to access the ```qux(text:String)->String``` of the ```QuxableFoo``` structure.

So this solution won't work either.
*/
/*: tl;dr: Preface for Compositions
## Compositions
The key idea using this approach is to define a generic protocol which has to be implemented by any corresponding type. All these corresponding types are composed into one object type which responds to the generic protocol but also knows how to handle the specific implementation of the specific types.

Since the ```Quxable``` protocol seems to be a good approach we will use it as our *generic* protocol and implement our solution around it.

### Defining The Parent Class
*/
class ParentClass : Quxable {

	var title = "Parent"

	func qux(text: String) -> String {

		return title
	}
}

let parentObject = ParentClass()
parentObject.qux( "Hö" )

//:### Defining The Subclasses

class QuxableFooClass : ParentClass {

	override func qux(text: String) -> String {

		super.qux(text)
		return fooQuxxle(text)
	}

	func fooQuxxle(text: String) -> String {

		self.title = text
		print( "Foo qux': \(self.title)!" )
		return "Foo"
	}
}

class QuxableBarClass : ParentClass {

	override func qux(text: String) -> String {

		super.qux(text)
		return barQuxxle(text)
	}

	func barQuxxle(text: String) -> String {

		self.title = text
		print( "Bar qux': \(self.title)!" )
		return "Bar"
	}
}

class QuxableBazClass : ParentClass {

	override func qux(text: String) -> String {

		super.qux(text)
		return bazQuxxle(text)
	}

	func bazQuxxle(text: String) -> String {

		self.title = text
		print( "Baz qux': \(self.title)!" )
		return "Baz"
	}
}
//: ### Defining The Composed Classes
class ComposedQuxableClass : Quxable {

	let fooObject = QuxableFooClass()
	let barObject = QuxableBarClass()
	let bazObject = QuxableBazClass()

	func qux(text: String) -> String {

		fooObject.qux(text)
		barObject.qux(text)
		bazObject.qux(text)

		return "Bäm"
	}
}

let composedQuxableObject = ComposedQuxableClass()
composedQuxableObject.qux( "Meow!" )
/*: tl;dr Use the right one.
### Conclusion
This is it. One correct approach to get the stuff done the way I want it to.

Just create one specific subclass and glue them all together in an composed object.

## Final Thoughts
I might find the approach unusable for my specific usecase, but for now I'm glad I made it that far.
*/
