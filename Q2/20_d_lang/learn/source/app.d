import std.stdio;
import std.conv;
import std.array;
import std.algorithm;

int twice(int x) {
	return x * 2;
}

// Running the debugger with -unittest flag will run tests before the main program
// NOTE: These will only display in the compile output IF THEY FAIL
unittest {
	assert (twice(2) == 4);
	assert (twice(-4) == -8);
}

struct Character {
	string name;
	string race;
	string cls;
	int level;

	void repr() const { // "const" means that the function is not allowed to modify the properties
		writefln("%s is a Level %s %s %s", name, level, race, cls);
	}

	private void privateFoo() { // Private means internal use only
		writeln("Blah");
	}

	static void reprFormat() { // Can be used without an instance
		writeln("<name> is a Level <level> <race> <cls>");
	}
}

abstract class Animal {
	// Protected only is visible by inheriting classes
	protected string species;
	protected int size;

	this(string species, int size) {
		this.species = species;
		this.size = size;
	}

	// "final" disallows overriding the function
	final string getSpecies() {
		return this.species;
	}

	public:  // Allows for larger scale declaration of protection level

	void repr() {
		writefln("Species: %s\nSize: %s", this.species, this.size);
	}
}

class Dog : Animal {
	this(int size) {
		super("Dog", size);
	}
}

interface Vehicle {
	void makeNoise();

	/+ Doing this allows you to define specific behaviors for inheriting classes
		 which are based upon the behavior of other overrideable functions.
		 This is known as a "Non-Virtual Interface" (NVI) Pattern.
	+/
	final doubleNoise() {
		makeNoise();
		makeNoise();
	}
}

class Car : Vehicle {
	override void makeNoise() {
		writeln("Beep beep");
	}
}

auto add(T)(T left, T right) {
	return left + right;
}

int mult(int left, int right) {
	return left * right;
}

int doFunc(int function(int, int) fn) {
	return fn(5, 5);
}

void main()
{
	writeln("Hello World!");
	int x = 2;
	writeln(twice(x));
	// "immutables"
	immutable int y = 2;
	// If/Else
	if(x == 3) {
		writeln("wait what?");
	} else if (y == 2) {
		writeln("Oh good.");
	} else {
		writeln("ummmm...");
	}
	// Ternaries
	writeln((y < 4) ? "Yup" : "Nope");
	switch(x) {
		case 1:
			writeln("bad juju");
			break;
		case 2:
			writeln("Yay");
			break;
		default:
			writeln("oh no");
			break;
	}
	// Struct usage
	auto max = Character("Max", "Human", "Rogue", 28);
	max.repr();
	Character.reprFormat();
	// Fixed-length array
	int[8] arr = [1,2,3,4,5,6,7,8];
	// Dynamic-length array
	int size = 8;
	int[] bigArr = new int[size];
	arr[] *= 2; // Multiply all the values in arr by 2
	writeln(arr);
	// type conversion
	int start = 3;
	string end = to!string(start);
	writeln(end);
	// Loops
	foreach (el; arr) {
		writeln(el);
	}
	// labeled looping
	outer: for(int a = 0; a < 5; a++) {
		for(int b = 0; b < 3; b++) {
			if (b == 1) {	continue outer; } // Will break the "outer" labeled loop in this case
			writefln("a = %s, b = %s", a, b);
		}
	}
	// Loop by ref on an array to mutate in-place, or to avoid copying large types:
	foreach(ref el; arr) {
		if(el > 10) { el = 10; }
	}
	writeln(arr);
	// iterate set number of times:
	foreach(z; 0..3) { writeln(z); }
	// iterate with index counter:
	foreach(i, e; [4,5,6]) { writeln(i, ":", e); }
	// builtin "reverse foreach":
	foreach_reverse(e; [1,2,3]) { writeln(e); }
	// hash maps:
	int[string] hm; //Key: string | Value: int
	hm["key"] = 10;
	if("key" in hm) { writeln("Found key"); }
	// "in" returns pointer (null or otherwise), so you can combine checks for assignment if not null:
	if(auto val = "key" in hm) { *val = 20; }
	writeln(hm["key"]);
	// Classes
	Dog puppy = new Dog(5);
	writeln(puppy.getSpecies());
	// Interfaces
	auto car = new Car;
	car.makeNoise();
	// Templating
	writeln(add!int(5, 10)); // the "!int" part is not _needed_ - it can deduce the type from params
	writeln(add!float(5.4, 3.2));
	// Delegates
	writeln(doFunc(&mult));
	auto f = (int a, int b) => a + b;
	writeln(f(1,2));
	writeln([1,2,3].reduce!`a + b`);
	// UFCS -> Universal Function Call Syntax
	3.twice().writeln(); // Allows changing nested calls into chained calls for readability
}
