script "cc_list.ash"

#	All lists have the construct type[int] and are 0-indexed, like nature intended.
#	Types: familiar
# 	Replace TYPE with types above
#	TYPE[int] TYPEList();								Empty List Construction
#	TYPE[int] TYPEList(boolean[TYPE]);					Create from existing map
#	TYPE[int] TYPEList(TYPE[int]);						Create from existing int map
#	TYPE[int] TYPEListRemove(TYPE[int], TYPE);			Remove all elements matching what
#	TYPE[int] TYPEListErase(TYPE[int], int);			Remove element at index
#	TYPE[int] TYPEListInsertFront(TYPE[int], TYPE);		Insert at start of list
#	TYPE[int] TYPEListInsert(TYPE[int], TYPE);			Insert at end of list
#	TYPE[int] TYPEListInsertAt(TYPE[int], TYPE, int);	Insert at a given index, push all elements at index forward
#	TYPE[int] TYPEListInsertInorder(TYPE[int], TYPE);	Insert inorder based on string value, assumes invariant
#	int TYPEListFind(TYPE[int], TYPE);					Returns location of element, -1 otherwise
#	int TYPEListFind(TYPE[int], TYPE, int);				Returns location of element, -1 otherwise, starting from index
#	TYPEListOutput(TYPE[int]);							Prints a comma-separated version of the list

# Printer
string familiarListOutput(familiar[int] list);

# Default Constructors
familiar[int] familiarList();

# Explicit Constructors (from map boolean[type])
familiar[int] familiarList(boolean[familiar] data);

# Explicit Constructors (from map type[int])
familiar[int] familiarList(familiar[int] data);

# Removal element/index
familiar[int] familiarListRemove(familiar[int] list, familiar what);
familiar[int] familiarListErase(familiar[int] list, int index);

# Insertion head/tail/at/inorder
familiar[int] familiarListInsertFront(familiar[int] list, familiar what);
familiar[int] familiarListInsert(familiar[int] list, familiar what);
familiar[int] familiarListInsertAt(familiar[int] list, familiar what, int idx);
familiar[int] familiarListInsertInorder(familiar[int] list, familiar what);

# Searching
int familiarListFind(familiar[int] list, familiar what);
int familiarListFind(familiar[int] list, familiar what, int idx);

# Printer
string familiarListOutput(familiar[int] list);

familiar[int] familiarList()
{
	familiar[int] retval;
	return retval;
}

familiar[int] familiarList(boolean[familiar] data)
{
	familiar[int] retval;
	int index = 0;

	foreach el in data
	{
		retval[index] = el;
		index = index + 1;
	}
	return retval;
}

familiar[int] familiarList(familiar[int] data)
{
	familiar[int] retval;

	//To handle constants if they are passed by const
	familiar[int] temp;
	foreach idx, el in data
	{
		temp[idx] = el;
	}
#	print(familiarListOutput(data), "red");
#	print(familiarListOutput(temp), "gray");
	sort temp by index;

	int index = 0;
	foreach idx, el in temp
	{
		retval[index] = el;
		index = index + 1;
	}

	return retval;
}

int familiarListFind(familiar[int] list, familiar what)
{
	return familiarListFind(list, what, 0);
}

int familiarListFind(familiar[int] list, familiar what, int idx)
{
	if(idx < 0)
	{
		abort("Attempted index out of bounds: " + idx);
	}
	familiar[int] retval = familiarList(list);
	int at = idx;
	while(at < count(retval))
	{
		if(what == retval[at])
		{
			return at;
		}
		at = at + 1;
	}
	return -1;
}


familiar[int] familiarListRemove(familiar[int] list, familiar what)
{
	familiar[int] retval = familiarList(list);
#	print(familiarListOutput(list), "red");
#	print(familiarListOutput(retval), "gray");
	foreach idx, el in retval
	{
		if(el == what)
		{
			remove retval[idx];
		}
	}
	return familiarList(retval);
}

familiar[int] familiarListErase(familiar[int] list, int index)
{
	familiar[int] retval = familiarList(list);
#	print(familiarListOutput(list), "red");
#	print(familiarListOutput(retval), "gray");
	remove retval[index];
	return familiarList(retval);
}

familiar[int] familiarListInsertFront(familiar[int] list, familiar what)
{
	familiar[int] retval = familiarList(list);
	retval[-1] = what;
	return familiarList(retval);
}

familiar[int] familiarListInsert(familiar[int] list, familiar what)
{
	familiar[int] retval = familiarList(list);
	retval[count(retval)] = what;
	return familiarList(retval);
}

familiar[int] familiarListInsertAt(familiar[int] list, familiar what, int idx)
{
	if((idx < 0) || (idx >= count(list)))
	{
		abort("List index " + idx + " out of bounds: " + count(list));
	}
	familiar[int] retval = familiarList(list);
	int shift = count(retval);
	while(shift > idx)
	{
		retval[shift] = retval[shift-1];
		shift = shift - 1;
	}
	retval[idx] = what;
	return retval;
}

familiar[int] familiarListInsertInorder(familiar[int] list, familiar what)
{
	familiar[int] retval = familiarList(list);
	if(to_string(what) < to_string(retval[0]))
	{
		return familiarListInsertAt(list, what, 0);
	}
	int shift = count(retval);
	while(shift > 0)
	{
		if(to_string(what) > to_string(retval[shift-1]))
		{
			retval[shift] = what;
			return retval;
		}
		retval[shift] = retval[shift-1];
		shift = shift - 1;
	}
	if(shift == 0)
	{
		abort("Inorder Insertion Failure");
	}
	return retval;
}

string familiarListOutput(familiar[int] list)
{
	string retval;
	if(count(list) > 0)
	{
		retval = to_string(list[0]);
		int index = 1;
		while(index < count(list))
		{
			retval = retval + ", " + to_string(list[index]);
			index = index + 1;
		}
	}

	return retval;
}


void main()
{
	boolean[familiar] test = $familiars[Slimeling, Puck Man, Baby Gravy Fairy, Intergnat, Mosquito];
	familiar[int] list = familiarList(test);

	print("First list", "green");
	print(familiarListOutput(list), "blue");

	print("Deleting Baby Gravy Fairy, (2)", "green");
	list = familiarListRemove(list, $familiar[Baby Gravy Fairy]);
	print(familiarListOutput(list), "blue");

	print("Deleting Element 1 (Puck Man)", "green");
	list = familiarListErase(list, 1);
	print(familiarListOutput(list), "blue");

	print("Inserting at Front (Exotic Parrot)", "green");
	list = familiarListInsertFront(list, $familiar[Exotic Parrot]);
	print(familiarListOutput(list), "blue");

	print("Inserting at End (Leprechaun)", "green");
	list = familiarListInsert(list, $familiar[Leprechaun]);
	print(familiarListOutput(list), "blue");

	print("Inserting at 2 (Artistic Goth Kid)", "green");
	list = familiarListInsertAt(list, $familiar[Artistic Goth Kid], 2);
	print(familiarListOutput(list), "blue");

	print("Inserting at 0 (Artistic Goth Kid)", "green");
	list = familiarListInsertAt(list, $familiar[Artistic Goth Kid], 0);
	print(familiarListOutput(list), "blue");

	print("Inserting inorder weirdness (Bulky Buddy Box)", "green");
	list = familiarListInsertInorder(list, $familiar[Bulky Buddy Box]);
	print(familiarListOutput(list), "blue");

	print("Inserting inorder weirdness (Xiblaxian Holo-Companion)", "green");
	list = familiarListInsertInorder(list, $familiar[Xiblaxian Holo-Companion]);
	print(familiarListOutput(list), "blue");

	int index = 0;
	while(index < count(list))
	{
		print(index + ": " + list[index] + ": " + familiarListFind(list, list[index]), "blue");
		index = index + 1;
	}
	print(3 + ": " + list[3] + ": " + list.familiarListFind(list[3], 1), "blue");
	print(3 + ": " + list[3] + ": " + list.familiarListFind(list[3], 2), "blue");
	print(3 + ": " + list[3] + ": " + list.familiarListFind(list[3], 3), "blue");
	print(3 + ": " + list[3] + ": " + list.familiarListFind(list[3], 4), "blue");
}
