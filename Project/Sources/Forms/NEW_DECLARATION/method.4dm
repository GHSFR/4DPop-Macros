var $e : Object
$e:=FORM Event:C1606

Case of 
		
		//______________________________________________________
	: ($e.code=On Load:K2:1)
		
		var $c : Collection
		$c:=New collection:C1472
		Form:C1466.boolean:=cs:C1710.button.new("boolean").bestSize().highlightShortcut()
		$c.push(Form:C1466.boolean)
		Form:C1466.blob:=cs:C1710.button.new("blob").bestSize().highlightShortcut()
		$c.push(Form:C1466.blob)
		Form:C1466.collection:=cs:C1710.button.new("collection").bestSize().highlightShortcut()
		$c.push(Form:C1466.collection)
		Form:C1466.date:=cs:C1710.button.new("date").bestSize().highlightShortcut()
		$c.push(Form:C1466.date)
		Form:C1466.integer:=cs:C1710.button.new("integer").bestSize().highlightShortcut()
		$c.push(Form:C1466.integer)
		Form:C1466.object:=cs:C1710.button.new("object").bestSize().highlightShortcut()
		$c.push(Form:C1466.object)
		Form:C1466.picture:=cs:C1710.button.new("picture").bestSize().highlightShortcut()
		$c.push(Form:C1466.picture)
		Form:C1466.pointer:=cs:C1710.button.new("pointer").bestSize().highlightShortcut()
		$c.push(Form:C1466.pointer)
		Form:C1466.real:=cs:C1710.button.new("real").bestSize().highlightShortcut()
		$c.push(Form:C1466.real)
		Form:C1466.text:=cs:C1710.button.new("text").bestSize().highlightShortcut()
		$c.push(Form:C1466.text)
		Form:C1466.time:=cs:C1710.button.new("time").bestSize().highlightShortcut()
		$c.push(Form:C1466.time)
		Form:C1466.variant:=cs:C1710.button.new("variant").bestSize().highlightShortcut()
		$c.push(Form:C1466.variant)
		
		Form:C1466.filterMenu:=cs:C1710.widget.new("filter")
		
		Form:C1466.tab:=cs:C1710.widget.new("control")
		$c.push(Form:C1466.tab)
		
		Form:C1466.list:=cs:C1710.scrollable.new("declarationList")
		
		Form:C1466.isSelected:=cs:C1710.group.new($c)
		
		OBJECT SET SCROLLBAR:C843(*; "declarationList"; 0; 2)
		
		var $o : Object
		
		For each ($o; Form:C1466.variables)
			
			$o.icon:=Form:C1466.types[Num:C11($o.type)].icon
			
		End for each 
		
		SELECT LIST ITEMS BY POSITION:C381(*; "filter"; 1)
		Form:C1466.subset:=Form:C1466.variables
		
		LISTBOX SELECT ROW:C912(*; "declarationList"; 1; lk replace selection:K53:1)
		
		SET TIMER:C645(-1)
		
		//______________________________________________________
	: ($e.code=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		Form:C1466.display()
		
		//______________________________________________________
	: ($e.code=On Validate:K2:3)
		
		Form:C1466.apply()
		
		//______________________________________________________
	: (Form:C1466.list.catch($e))
		
		Form:C1466.display()
		
		//______________________________________________________
	: (Form:C1466.filterMenu.catch($e))
		
		Form:C1466.getFilter()
		
		//______________________________________________________
	: (Form:C1466.boolean.catch($e))
		
		Form:C1466.setType(Is boolean:K8:9)
		
		//______________________________________________________
	: (Form:C1466.blob.catch($e))
		
		Form:C1466.setType(Is BLOB:K8:12)
		
		//______________________________________________________
	: (Form:C1466.collection.catch($e))
		
		Form:C1466.setType(Is collection:K8:32)
		
		//______________________________________________________
	: (Form:C1466.date.catch($e))
		
		Form:C1466.setType(Is date:K8:7)
		
		//______________________________________________________
	: (Form:C1466.integer.catch($e))
		
		Form:C1466.setType(Is longint:K8:6)
		
		//______________________________________________________
	: (Form:C1466.object.catch($e))
		
		Form:C1466.setType(Is object:K8:27)
		
		//______________________________________________________
	: (Form:C1466.picture.catch($e))
		
		Form:C1466.setType(Is picture:K8:10)
		
		//______________________________________________________
	: (Form:C1466.pointer.catch($e))
		
		Form:C1466.setType(Is pointer:K8:14)
		
		//______________________________________________________
	: (Form:C1466.real.catch($e))
		
		Form:C1466.setType(Is real:K8:4)
		
		//______________________________________________________
	: (Form:C1466.text.catch($e))
		
		Form:C1466.setType(Is text:K8:3)
		
		//______________________________________________________
	: (Form:C1466.time.catch($e))
		
		Form:C1466.setType(Is time:K8:8)
		
		//______________________________________________________
	: (Form:C1466.variant.catch($e))
		
		Form:C1466.setType(Is variant:K8:33)
		
		//______________________________________________________
End case 