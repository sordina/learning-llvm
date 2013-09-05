
----

# Org Chart

_Imagine the following scenario:_

You are an employee of International Banking Machines.

The CEO has asked you to model the org-chart with a computer program in order
to perform some analysis on the effectiveness of middle-managers.

Before you are able to perform your calculations, you will have to decide how you
will model your data. Construct a Haskell data-type to represent the various types
of employees and departments for an organisation in the style of the following
diagram:

<div class="center nopad">![Org Chart](resources/images/dot/01.png)</div>

\startmode[html]
~~~{.hidden data-language="dot" data-output="resources/images/dot/01.png" data-filter="./resources/scripts/graph.sh"}
digraph IBM {
	graph [ dpi = 100 ];

	b1 [label="IBM - Board of Directors"];

	b1 -> CTO [label=Tech];
	b1 -> CFO [label=Money];
	b1 -> CEO [label=Power];
	CEO -> BurgerFlipping;
	BurgerFlipping -> Fries;
	Fries -> CurlyDepartment;
	Fries -> Regulations;
	BurgerFlipping -> FrontDesk;
	CTO -> Engineering;
	CFO -> HR;
	CFO -> SpyStuff;
	Engineering -> Products;
	HR -> Piñatas;

	Products -> x3 [arrowhead=odot];
	x3 [shape=rectangle label="Employees: 11\n Manager: Dennis"];

	CurlyDepartment -> x4 [arrowhead=odot];
	x4 [shape=rectangle label="Employees: 14\n Manager: Darren"];

	Regulations -> x5 [arrowhead=odot];
	x5 [shape=rectangle label="Employees: 18\n Manager: Dylan"];

	FrontDesk -> x6 [arrowhead=odot];
	x6 [shape=rectangle label="Employees: 23\n Manager: Devin"];

	Piñatas -> x7 [arrowhead=odot];
	x7 [shape=rectangle label="Employees: 22\n Manager: Dorris"];
}
~~~
\stopmode

~~~{ data-language=haskell data-filter=./resources/scripts/check.sh }
data OrgChart   = Chart Department                      deriving Show
data Department = Dep Name [ Child ]                    deriving Show
data Child      = Child ArrowLabel Item                 deriving Show
data Item       = Person Person | Department Department deriving Show
data Person     = Human Title                           deriving Show

type ArrowLabel = String
type Name       = String
type Title      = String
~~~

Construct a function that builds up your datastructure from the following
plain-text input format: 

## Employees

------  -------  ------  ----------------  -------------------  ------------
Name    Title    Salary  Department        Managing Department  Subordinates
------  -------  ------  ----------------  -------------------  ------------
Dennis  Manager  $33K    Products          Products             11

Dorris  Manager  $42K    Piñatas           HR                   22

Darren  Manager  $34K    Curly Department  Fries                13

Dylan   Manager  $54K    Regulations       Fries                18

Devin   Manager  $64K    Front Desk        BurgerFlipping       23
------  -------  ------  ----------------  -------------------  ------------

Your function should have the following signature:

~~~{ data-language=haskell .nocheck }
process :: String -> OrgChart
~~~

The following functions should provide you the power required to construct your Org-Chart:

* lines
* words
