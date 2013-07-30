
<hr>

Exercise - Org Chart
====================

You are an employee of International Banking Machines.

The CEO has asked you to model the org-chart with a computer program in order
to perform some analysis on the effectiveness of middle-managers.

Before you are able to perform your calculations, you will have to decide how you
will model your data. Construct a Haskell data-type to represent the various types
of employees and departments shown in the following diagram:

<div class="center">![Org Chart](resources/images/dot/01.png)</div>

\startmode[html]
~~~{.hidden data-language="dot" data-output="resources/images/dot/01.png" data-filter="./resources/scripts/graph.sh"}
digraph IBM {
	graph [ dpi = 100 ];

	b1 [label="IBM - Board of Directors"];

	b1 -> CTO [label=tech];
	b1 -> CFO [label=money];
	b1 -> CEO [label=power];
	CEO -> BurgerFlipping;
	BurgerFlipping -> Fries;
	Fries -> CurlyDepartment;
	Fries -> Regulations;
	BurgerFlipping -> FrontDesk;
	CTO -> Operations;
	CTO -> Engineering;
	CFO -> HR;
	CFO -> SpyStuff;
	Engineering -> Products;
	Operations -> Africa;
	Operations -> Brazil;
	HR -> Piniatas;
	SpyStuff -> Piniatas;

	Africa -> x1 [arrowhead=odot];
	x1 [shape=rectangle label="Employees: 13\n Manager: Damien"];

	Brazil -> x2 [arrowhead=odot];
	x2 [shape=rectangle label="Employees: 19\n Manager: Dave"];

	Products -> x3 [arrowhead=odot];
	x3 [shape=rectangle label="Employees: 11\n Manager: Dennis"];

	CurlyDepartment -> x4 [arrowhead=odot];
	x4 [shape=rectangle label="Employees: 14\n Manager: Darren"];

	Regulations -> x5 [arrowhead=odot];
	x5 [shape=rectangle label="Employees: 18\n Manager: Dylan"];

	FrontDesk -> x6 [arrowhead=odot];
	x6 [shape=rectangle label="Employees: 23\n Manager: Devin"];

	Piniatas -> x7 [arrowhead=odot];
	x7 [shape=rectangle label="Employees: 22\n Manager: Dorris"];
}
~~~
\stopmode
