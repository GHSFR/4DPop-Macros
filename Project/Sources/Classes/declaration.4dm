Class extends macro

Class constructor
	
	Super:C1705()
	
	// Preferences
	var $fileSettings : 4D:C1709.File
	$fileSettings:=Folder:C1567(fk user preferences folder:K87:10).file("4DPop/4DPop Macros.settings")
	
	If ($fileSettings.original#Null:C1517)
		
		$fileSettings:=$fileSettings.original
		
	End if 
	
	If ($fileSettings.exists)
		
		This:C1470.settings:=JSON Parse:C1218($fileSettings.getText()).declaration
		
	Else 
		
		DECLARATION("Get_Syntax_Preferences")
		
	End if 
	
	This:C1470.lines:=New collection:C1472
	This:C1470.locales:=New collection:C1472
	This:C1470.parameters:=New collection:C1472
	This:C1470.classes:=New collection:C1472
	
	This:C1470.types:=New collection:C1472
	
	This:C1470.$notforArray:=New collection:C1472
	This:C1470.$notforArray.push("collection"; "variant")
	
	// Flags
	This:C1470.$inCommentBlock:=False:C215
	
	This:C1470.init()
	
	//==============================================================
Function init()
	
	var $icon : Picture
	var $root : Object
	var $suffix : Text
	
	$root:=Folder:C1567("/RESOURCES/Images/fieldIcons")
	
	$suffix:=(Get Application color scheme:C1763(*)="dark") ? "_dark.png" : ".png"
	
	READ PICTURE FILE:C678($root.file("field_00"+$suffix).platformPath; $icon)
	This:C1470.types[0]:=New object:C1471(\
		"name"; "undefined"; \
		"icon"; $icon)
	
	READ PICTURE FILE:C678($root.file("field_"+String:C10(Num:C11(Is object:K8:27); "00")+$suffix).platformPath; $icon)
	This:C1470.types[Is object:K8:27]:=New object:C1471(\
		"name"; "object"; \
		"icon"; $icon; \
		"value"; Is object:K8:27; \
		"arrayCommand"; 1221; \
		"directive"; 1216)
	
	READ PICTURE FILE:C678($root.file("field_"+String:C10(Num:C11(Is collection:K8:32); "00")+$suffix).platformPath; $icon)
	This:C1470.types[Is collection:K8:32]:=New object:C1471(\
		"name"; "collection"; \
		"icon"; $icon; \
		"value"; Is collection:K8:32; \
		"directive"; 1488)
	
	READ PICTURE FILE:C678($root.file("field_"+String:C10(Num:C11(Is longint:K8:6); "00")+$suffix).platformPath; $icon)
	This:C1470.types[Is longint:K8:6]:=New object:C1471(\
		"name"; "integer"; \
		"icon"; $icon; \
		"value"; Is longint:K8:6; \
		"arrayCommand"; 221; \
		"directive"; 283)
	
	READ PICTURE FILE:C678($root.file("field_"+String:C10(Num:C11(Is boolean:K8:9); "00")+$suffix).platformPath; $icon)
	This:C1470.types[Is boolean:K8:9]:=New object:C1471(\
		"name"; "boolean"; \
		"icon"; $icon; \
		"value"; Is boolean:K8:9; \
		"arrayCommand"; 223; \
		"directive"; 305)
	
	READ PICTURE FILE:C678($root.file("field_"+String:C10(Num:C11(Is text:K8:3); "00")+$suffix).platformPath; $icon)
	This:C1470.types[Is text:K8:3]:=New object:C1471(\
		"name"; "text"; \
		"icon"; $icon; \
		"value"; Is text:K8:3; \
		"arrayCommand"; 222; \
		"directive"; 284)
	
	READ PICTURE FILE:C678($root.file("field_"+String:C10(Num:C11(Is date:K8:7); "00")+$suffix).platformPath; $icon)
	This:C1470.types[Is date:K8:7]:=New object:C1471(\
		"name"; "date"; \
		"icon"; $icon; \
		"value"; Is date:K8:7; \
		"arrayCommand"; 224; \
		"directive"; 307)
	
	READ PICTURE FILE:C678($root.file("field_"+String:C10(Num:C11(Is time:K8:8); "00")+$suffix).platformPath; $icon)
	This:C1470.types[Is time:K8:8]:=New object:C1471(\
		"name"; "time"; \
		"icon"; $icon; \
		"value"; Is time:K8:8; \
		"arrayCommand"; 1223; \
		"directive"; 306)
	
	READ PICTURE FILE:C678($root.file("field_"+String:C10(Num:C11(Is picture:K8:10); "00")+$suffix).platformPath; $icon)
	This:C1470.types[Is picture:K8:10]:=New object:C1471(\
		"name"; "picture"; \
		"icon"; $icon; \
		"value"; Is picture:K8:10; \
		"arrayCommand"; 279; \
		"directive"; 286)
	
	READ PICTURE FILE:C678($root.file("field_"+String:C10(Num:C11(Is variant:K8:33); "00")+$suffix).platformPath; $icon)
	This:C1470.types[Is variant:K8:33]:=New object:C1471(\
		"name"; "variant"; \
		"icon"; $icon; \
		"value"; Is variant:K8:33; \
		"directive"; 1683)
	
	READ PICTURE FILE:C678($root.file("field_"+String:C10(Num:C11(Is pointer:K8:14); "00")+$suffix).platformPath; $icon)
	This:C1470.types[Is pointer:K8:14]:=New object:C1471(\
		"name"; "pointer"; \
		"icon"; $icon; \
		"value"; Is pointer:K8:14; \
		"arrayCommand"; 280; \
		"directive"; 301)
	
	READ PICTURE FILE:C678($root.file("field_"+String:C10(Num:C11(Is BLOB:K8:12); "00")+$suffix).platformPath; $icon)
	This:C1470.types[Is BLOB:K8:12]:=New object:C1471(\
		"name"; "blob"; \
		"icon"; $icon; \
		"value"; Is BLOB:K8:12; \
		"arrayCommand"; 1222; \
		"directive"; 604)
	
	READ PICTURE FILE:C678($root.file("field_"+String:C10(Num:C11(Is real:K8:4); "00")+$suffix).platformPath; $icon)
	This:C1470.types[Is real:K8:4]:=New object:C1471(\
		"name"; "real"; \
		"icon"; $icon; \
		"value"; Is real:K8:4; \
		"arrayCommand"; 219; \
		"directive"; 285)
	
	This:C1470.loadGramSyntax()
	
	//==============================================================
Function split() : cs:C1710.declaration
	
	Super:C1706.split(This:C1470.withSelection)
	
	return (This:C1470)
	
	//==============================================================
	// Parses the code to extract parameters and local variables
Function parse() : cs:C1710.declaration
	
	var $comment; $t; $text : Text
	var $static : Boolean
	var $index; $l : Integer
	var $line; $o; $parameter; $rgx; $var : Object
	var $c : Collection
	
	ARRAY LONGINT:C221($len; 0x0000)
	ARRAY LONGINT:C221($pos; 0x0000)
	
	var $options : Object
	$options:=This:C1470.settings.options
	
	This:C1470.removeDirective()
	This:C1470.split()
	
	For each ($text; This:C1470.lineTexts)
		
		$line:=New object:C1471(\
			"code"; $text)
		
		$comment:=""
		
		Case of 
				
				//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
			: (Length:C16($text)=0)  // EMPTY LINE
				
				$line.type:=Choose:C955(This:C1470.$inCommentBlock; "comment"; "empty")
				
				//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
			: (Position:C15("#DECLARE"; $line.code)=1)  // #DECLARE
				
				$line.type:="#DECLARE"
				$line.skip:=True:C214
				This:C1470.parseParameters($line)
				
				//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
			: (Position:C15("Class constructor"; $line.code)=1)  // Constructor
				
				$line.type:="Class constructor"
				$line.skip:=True:C214
				This:C1470.parseParameters($line)
				
				//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
			: (Match regex:C1019("(?m-si)^(?!//)(?:.*\\s)?Function\\s.*$"; $line.code; 1))  // Function
				
				$line.type:="Function"
				$line.skip:=True:C214
				This:C1470.parseParameters($line)
				
				//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
			: (Match regex:C1019("(?mi-s)^(//)|(/\\*)|(?:.*(\\*/))"; $line.code; 1; $pos; $len))  // COMMENTS
				
				$line.type:="comment"
				
				Case of 
						
						//======================================
					: ($pos{2}>0)  // Begin comment block
						
						This:C1470.$inCommentBlock:=Not:C34(Match regex:C1019("(?mi-s)^/\\*.*\\*/"; $line.code; 1))
						
						//======================================
					: ($pos{3}>0)  // End comment block
						
						This:C1470.$inCommentBlock:=False:C215
						
						//======================================
				End case 
				
				//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
			: (This:C1470.$inCommentBlock)  // In comment block
				
				$line.type:="comment"
				
				//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
			Else 
				
				// Remove textual values
				Rgx_SubstituteText("(?m-si)(\"[^\"]*\")"; ""; ->$text)
				
				// Remove Comments
				Rgx_SubstituteText("(?m-si)(//.*$)"; ""; ->$text)
				
				// Searches parameters $0-N & ${N} into the line
				
/*------------------------------------------------------
declaration macro must omit the parameters of a formula
--> https:// Github.com/vdelachaux/4DPop-Macros/issues/6
--------------------------------------------------------*/
				$t:=$text
				$l:=Position:C15(Parse formula:C1576("Formula:C1597")+"("; $text; 1; *)
				
				If ($l>0)
					
					$c:=Split string:C1554(Substring:C12($text; $l); "(")
					$c[$c.length-1]:=Replace string:C233($c[$c.length-1]; ")"; ""; $c.length-2)
					$text:=Replace string:C233($text; $c.join("("); "")
					
				End if 
				
				$rgx:=Rgx_match(New object:C1471(\
					"pattern"; "(?mi-s)(\\$\\{?\\d+\\}?)+(?!\\w)"; \
					"target"; $text; \
					"all"; True:C214))
				
				$text:=$t
/*--------------------------------------------------------*/
				
				If ($rgx.success)  // PARAMETER(S)
					
					For each ($t; $rgx.match.extract("data").distinct())
						
						$parameter:=This:C1470.parameters.query("value=:1"; $t).pop()
						
						If ($parameter=Null:C1517)
							
							$parameter:=New object:C1471(\
								"parameter"; True:C214; \
								"value"; $t; \
								"code"; $line.code; \
								"count"; 0; \
								"label"; Choose:C955($t="$0"; "← "; "→ ")+$t; \
								"order"; Num:C11($t))
							
							This:C1470.parameters.push($parameter)
							
						Else 
							
							$parameter.count:=$parameter.count+1
							
						End if 
						
						If ($parameter.type=Null:C1517)
							
							If (Match regex:C1019("(?mi-s)var\\s|C_"; $text; 1))  // Declaration line
								
								If (Match regex:C1019("(?mi-s)\\s*:\\s*(?:Object)|((?:cs\\.\\w+)|(?:4D\\.\\w+))"; $text; 1; $pos; $len))
									
									If ($pos{1}#-1)
										
										$parameter.class:=Substring:C12($text; $pos{1}; $len{1})
										
									End if 
									
									$parameter.type:=Is object:K8:27
									
								Else 
									
									$line.type:="declaration"
									$line.skip:=True:C214
									$parameter.type:=This:C1470.getTypeFromDeclaration($text)
									
								End if 
								
								If (Match regex:C1019("(?mi-s)//(.*)$"; $line.code; 1; $pos; $len))
									
									$parameter.comment:=Substring:C12($line.code; $pos{1}; $len{1})
									
								End if 
								
							Else   // Try to be clairvoyant
								
								$parameter.type:=This:C1470.clairvoyant($t; $line.code)
								
							End if 
						End if 
					End for each 
					
					This:C1470.parameters:=This:C1470.parameters.distinct(ck diacritical:K85:3)
					
				End if 
				
				Case of 
						
						//======================================
					: (Match regex:C1019("(?mi-s)var\\s|C_"; $text; 1))  // DECLARATION LINE
						
						$line.type:="declaration"
						$line.skip:=True:C214
						
						$rgx:=Rgx_match(New object:C1471(\
							"pattern"; "(?m-si)(?<!\\.)(\\$\\w+)"; \
							"target"; $text; \
							"all"; True:C214))
						
						If ($rgx.success)
							
							For each ($t; $rgx.match.extract("data").distinct())
								
								If (Match regex:C1019("(?mi-s)(\\$\\{?\\d+\\}?)+(?!\\w)"; $t; 1))  // Parameter
									
									$parameter:=This:C1470.parameters.query("value=:1"; $t).pop()
									
									If ($parameter=Null:C1517)
										
										$parameter:=New object:C1471(\
											"parameter"; True:C214; \
											"value"; $t; \
											"code"; $line.code; \
											"count"; 0; \
											"label"; Choose:C955($t="0"; "← "; "→ ")+$t)
										
										This:C1470.parameters.push($parameter)
										
									Else 
										
										$parameter.count:=$parameter.count+1
										
									End if 
									
								Else 
									
									$var:=This:C1470.locales.query("value=:1"; $t).pop()
									
									If ($var=Null:C1517)
										
										$var:=New object:C1471(\
											"value"; $t; \
											"code"; $line.code; \
											"count"; 0; \
											"label"; $t; \
											"inDeclaration"; True:C214)
										
										This:C1470.locales.push($var)
										
									Else 
										
										$var.count:=$var.count+1
										
									End if 
									
									If (Match regex:C1019("(?mi-s)\\s*:\\s*(?:Object)|((?:cs\\.\\w+)|(?:4D\\.\\w+))"; $text; 1; $pos; $len))
										
										If ($pos{1}#-1)
											
											$var.class:=Substring:C12($text; $pos{1}; $len{1})
											
										End if 
										
										$var.type:=Is object:K8:27
										
									Else 
										
										$var.type:=This:C1470.getTypeFromDeclaration($text)
										
									End if 
								End if 
							End for each 
						End if 
						
						//======================================
					: (Match regex:C1019("(?mi-s)^(?:ARRAY|TABLEAU)\\s*[^(]*\\(([^;]*);\\s*[\\dx]+(?:;\\s*([\\dx]+))?\\)"; $text; 1; $pos; $len))  // ARRAY DECLARATION
						
						$static:=Match regex:C1019("(?mi-s)0x"; $text; 1)
						
						If (Not:C34($static))
							
							$line.type:="declaration"
							$line.skip:=True:C214
							
						End if 
						
						$t:=Substring:C12($line.code; $pos{1}; $len{1})
						$var:=This:C1470.locales.query("value=:1"; $t).pop()
						
						If ($var=Null:C1517)
							
							$var:=New object:C1471(\
								"value"; $t; \
								"code"; $line.code; \
								"count"; 0; \
								"label"; $t)
							
							This:C1470.locales.push($var)
							
						Else 
							
							$var.count:=$var.count+1
							
						End if 
						
						$var.array:=True:C214
						$var.dimension:=1+Num:C11(($pos{2}#-1))
						$var.static:=$static
						$var.type:=This:C1470.getTypeFromDeclaration($text)
						
						//======================================
					Else   // EXTRACT LOCAL VARIABLES
						
						$rgx:=Rgx_match(New object:C1471(\
							"pattern"; "(?m-si)(?<!\\.)(\\$\\w+)"; \
							"target"; $text; \
							"all"; True:C214))
						
						If ($rgx.success)
							
							For each ($t; $rgx.match.extract("data").distinct())
								
								If (Not:C34(Match regex:C1019("(?mi-s)(\\$\\{?\\d+\\}?)+(?!\\w)"; $t; 1)))
									
									$var:=This:C1470.parameters.query("value=:1"; $t).pop()
									
									If ($var=Null:C1517)
										
										$var:=This:C1470.locales.query("value=:1"; $t).pop()
										
										If ($var=Null:C1517)
											
											$var:=New object:C1471(\
												"value"; $t; \
												"code"; $line.code; \
												"count"; 1; \
												"label"; $t)
											
											This:C1470.locales.push($var)
											
										Else 
											
											$var.count:=$var.count+1
											
										End if 
										
										If ($var.type=Null:C1517)
											
											$var.type:=This:C1470.clairvoyant($t; $line.code)
											
											If ($var.type=0)
												
												$l:=This:C1470.getTypeFromRules($t)
												
												If ($l#0)  // Got a type from syntax parameters
													
													If ($l>100)
														
														$var.array:=True:C214
														$l:=$l-100
														
													End if 
													
													$var.type:=Choose:C955($l; \
														-1; \
														Is text:K8:3; \
														Is BLOB:K8:12; \
														Is boolean:K8:9; \
														Is date:K8:7; \
														Is longint:K8:6; \
														Is longint:K8:6; \
														-1; \
														Is time:K8:8; \
														Is picture:K8:10; \
														Is pointer:K8:14; \
														Is real:K8:4; \
														Is text:K8:3; \
														Is object:K8:27; \
														Is collection:K8:32; \
														Is variant:K8:33)
													
												Else 
													
													$var.type:=This:C1470.getTypeFromDeclaration($line.code)
													
													If ($var.type#0)
														
														If (Match regex:C1019("(?m-si)^(?:ARRAY|TABLEAU)\\s[^(]*\\([^;]*;[^;]*(?:;([^;]*))?\\)"; $line.code; 1))
															
															$var.array:=True:C214
															
														End if 
													End if 
												End if 
											End if 
										End if 
										
									Else 
										
										// Its a parameter
										$var.count:=$var.count+1
										
									End if 
								End if 
								
								If ($var#Null:C1517)
									
									If ($var.type=Is object:K8:27)
										
										Case of 
												
												//……………………………………………………………………………………………………
											: (Match regex:C1019("(?mi-s)\\"+$var.value+":=((?:cs|4d)\\.\\w*)\\.new\\([^)]*\\)(?!\\.)"; $line.code; 1; $pos; $len))
												
												$var.class:=Substring:C12($line.code; $pos{1}; $len{1})
												
												//……………………………………………………………………………………………………
											: (Match regex:C1019("(?mi-s)\\"+$var.value+":="+Parse formula:C1576("File:C1566")+"\\([^)]*\\)(?!\\.)"; $line.code; 1))
												
												$var.class:="4D.File"
												
												//……………………………………………………………………………………………………
											: (Match regex:C1019("(?mi-s)\\"+$var.value+":="+Parse formula:C1576("Folder:C1567")+"\\([^)]*\\)(?!\\.)"; $line.code; 1))
												
												$var.class:="4D.Folder"
												
												//……………………………………………………………………………………………………
											: (Match regex:C1019("(?mi-s)\\.\\w*(?:\\([^\\)]*\\))$"; $line.code; 1))
												
												Case of 
														
														//------------------------------------
													: (Bool:C1537($var.inDeclaration))
														
														// THE DECLARATION MUST WIN
														
														//------------------------------------
													: ($var.class#Null:C1517)
														
														$var.type:=38
														
														//------------------------------------
													: (False:C215)
														
														// MARK:#TODO - get from member fonction or attribute
														
														//------------------------------------
													Else 
														
														$var.type:=0
														
														//------------------------------------
												End case 
												
												//……………………………………………………………………………………………………
											Else 
												
												// A "Case of" statement should never omit "Else"
												
												//……………………………………………………………………………………………………
										End case 
										
									End if 
									
								Else 
									
									// ie. : This.url:=$1
									
								End if 
							End for each 
						End if 
						
						//======================================
				End case 
				
				//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
		End case 
		
		This:C1470.lines.push($line)
		
	End for each 
	
	This:C1470.localeNumber:=This:C1470.locales.length
	This:C1470.parameterNumber:=This:C1470.parameters.length
	
	This:C1470.locales:=This:C1470.locales.orderBy("value asc")
	This:C1470.parameters:=This:C1470.parameters.orderBy("value asc")
	
	// Place the parameter set last
	$o:=This:C1470.parameters.query("value=${@").pop()
	
	If ($o#Null:C1517)
		
		This:C1470.parameters.push($o)
		This:C1470.parameters.remove(This:C1470.parameters.indexOf($o))
		
	End if 
	
	// Finally do a flat list
	This:C1470.variables:=This:C1470.parameters.combine(This:C1470.locales)
	
	return (This:C1470)
	
	//==============================================================
Function parseParameters($line : Object)
	
	var $pattern; $t : Text
	var $index : Integer
	var $parameter; $rgx : Object
	var $c : Collection
	
	Case of 
			
			//______________________________________________________
		: ($line.type="Class constructor")
			
			$pattern:="(?mi-s)^(?!//)(.*)"+$line.type+"\\s*()(?:\\(([^)]*)\\))?\\s*()?\\s*(//[^$]*)?$"
			
			//______________________________________________________
		: ($line.type="Function")
			
			$pattern:="(?m-si)^(?!//)(.*)"+$line.type+"\\s([^(]*)(?:\\s*\\(([^)]*)\\))?(?:\\s*(?:->\\s*)?([^/]*))?\\s*(//[^$]*)?$"
			
			//______________________________________________________
		: ($line.type="#DECLARE")
			
			$pattern:="(?m-si)^(?!//)()"+$line.type+"()(?:\\s*\\(([^)]*)\\))?(?:\\s*(?:->\\s*)?([^/]*))?\\s*(//[^$]*)?$"
			
			//______________________________________________________
	End case 
	
	$rgx:=Rgx_match(New object:C1471(\
		"pattern"; $pattern; \
		"target"; $line.code; \
		"all"; True:C214))
	
	If ($rgx.success)
		
		//$1: keywords (ie. exposed)
		If ($rgx.match[1].length>0)
			
			$line.prefix:=$rgx.match[1].data
			
		End if 
		
		//$2: function name (ie. {get/set} myFunction)
		If ($rgx.match[2].length>0)
			
			$line.function:=$rgx.match[2].data
			
		End if 
		
		//$3: parameters
		If ($rgx.match[3].length>0)
			
			For each ($t; Split string:C1554($rgx.match[3].data; ";"))
				
				$index:=$index+1
				$c:=Split string:C1554($t; ":"; sk trim spaces:K86:2)
				
				$parameter:=New object:C1471(\
					"parameter"; True:C214; \
					"value"; Split string:C1554($c[0]; " "; sk ignore empty strings:K86:1).join(""); \
					"code"; $line.code; \
					"type"; Choose:C955($c.length=1; Is variant:K8:33; This:C1470.getTypeFromDeclaration($t)); \
					"count"; 0; \
					"order"; $index)
				
				$parameter.inDeclaration:=($parameter.type#0)
				$parameter.label:="← "+$parameter.value
				
				If ($c.length=2)
					
					If (Match regex:C1019("(?m-si)^\\s*((?:4D|cs)\\.[^$/]*)(/[^$]*)?$"; $c[1]; 1))
						
						$parameter.class:=$c[1]
						
					End if 
				End if 
				
				This:C1470.parameters.push($parameter)
				
			End for each 
		End if 
		
		//$4: return
		If ($rgx.match[4].length>0)
			
			$c:=Split string:C1554($rgx.match[4].data; ":"; sk trim spaces:K86:2)
			
			$parameter:=New object:C1471(\
				"parameter"; True:C214; \
				"return"; True:C214; \
				"value"; Split string:C1554($c[0]; " "; sk ignore empty strings:K86:1).join(""); \
				"code"; $line.code; \
				"type"; Choose:C955($c.length=1; Is variant:K8:33; This:C1470.getTypeFromDeclaration($rgx.match[4].data)); \
				"count"; 0; \
				"order"; 0)
			
			$parameter.inDeclaration:=($parameter.type#0)
			
			If ($c.length=2)
				
				If (Match regex:C1019("(?m-si)^\\s*((?:4D|cs)\\.[^$/]*)(/[^$]*)?$"; $c[1]; 1))
					
					$parameter.class:=$c[1]
					
				End if 
			End if 
			
			$parameter.label:="→ "+(Length:C16($parameter.value)>0 ? $parameter.value : "return()")
			
			This:C1470.parameters.push($parameter)
			
		End if 
		
		//$5: comments
		If (Length:C16($rgx.match[5].data)>0)
			
			$line.comment:=$rgx.match[5].data
			
		End if 
	End if 
	
	//==============================================================
Function getTypeFromDeclaration($text : Text)->$type : Integer
	
	Case of 
			
			//______________________________________________________
		: (Position:C15(Parse formula:C1576("C_LONGINT:C283"); $text)=1)\
			 | (Position:C15(Parse formula:C1576("ARRAY LONGINT:C221"); $text)=1)\
			 | (Position:C15(Parse formula:C1576("C_INTEGER:C282"); $text)=1)\
			 | Match regex:C1019("(?mi-s)\\s*:\\s*Integer\\s*(?:/[/*].*)?$"; $text; 1)
			
			$type:=Is longint:K8:6
			
			//______________________________________________________
		: (Position:C15(Parse formula:C1576("C_TEXT:C284"); $text)=1)\
			 | (Position:C15(Parse formula:C1576("ARRAY TEXT:C222"); $text)=1)\
			 | (Position:C15(Parse formula:C1576("C_STRING:C293"); $text)=1)\
			 | Match regex:C1019("(?mi-s)\\s*:\\s*Text\\s*(?:/[/*].*)?$"; $text; 1)
			
			$type:=Is text:K8:3
			
			//______________________________________________________
		: (Position:C15(Parse formula:C1576("C_REAL:C285"); $text)=1)\
			 | (Position:C15(Parse formula:C1576("ARRAY REAL:C219"); $text)=1)\
			 | Match regex:C1019("(?mi-s)\\s*:\\s*Real\\s*(?:/[/*].*)?$"; $text; 1)
			
			$type:=Is real:K8:4
			
			//______________________________________________________
		: (Position:C15(Parse formula:C1576("C_PICTURE:C286"); $text)=1)\
			 | (Position:C15(Parse formula:C1576("ARRAY PICTURE:C279"); $text)=1)\
			 | Match regex:C1019("(?mi-s)\\s*:\\s*Picture\\s*(?:/[/*].*)?$"; $text; 1)
			
			$type:=Is picture:K8:10
			
			//______________________________________________________
		: (Position:C15(Parse formula:C1576("C_POINTER:C301"); $text)=1)\
			 | (Position:C15(Parse formula:C1576("ARRAY POINTER:C280"); $text)=1)\
			 | Match regex:C1019("(?mi-s)\\s*:\\s*Pointer\\s*(?:/[/*].*)?$"; $text; 1)
			
			$type:=Is pointer:K8:14
			
			//______________________________________________________
		: (Position:C15(Parse formula:C1576("C_BOOLEAN:C305"); $text)=1)\
			 | (Position:C15(Parse formula:C1576("ARRAY BOOLEAN:C223"); $text)=1)\
			 | Match regex:C1019("(?mi-s)\\s*:\\s*Boolean\\s*(?:/[/*].*)?$"; $text; 1)
			
			$type:=Is boolean:K8:9
			
			//______________________________________________________
		: (Position:C15(Parse formula:C1576("C_TIME:C306"); $text)=1)\
			 | (Position:C15(Parse formula:C1576("ARRAY TIME:C1223"); $text)=1)\
			 | Match regex:C1019("(?mi-s)\\s*:\\s*Time\\s*(?:/[/*].*)?$"; $text; 1)
			
			$type:=Is time:K8:8
			
			//______________________________________________________
		: (Position:C15(Parse formula:C1576("C_DATE:C307"); $text)=1)\
			 | (Position:C15(Parse formula:C1576("ARRAY DATE:C224"); $text)=1)\
			 | Match regex:C1019("(?mi-s)\\s*:\\s*Date\\s*(?:/[/*].*)?$"; $text; 1)
			
			$type:=Is date:K8:7
			
			//______________________________________________________
		: (Position:C15(Parse formula:C1576("C_BLOB:C604"); $text)=1)\
			 | (Position:C15(Parse formula:C1576("ARRAY BLOB:C1222"); $text)=1)\
			 | Match regex:C1019("(?mi-s)\\s*:\\s*Blob\\s*(?:/[/*].*)?$"; $text; 1)
			
			$type:=Is BLOB:K8:12
			
			//______________________________________________________
		: (Position:C15(Parse formula:C1576("C_OBJECT:C1216"); $text)=1)\
			 | (Position:C15(Parse formula:C1576("ARRAY OBJECT:C1221"); $text)=1)\
			 | Match regex:C1019("(?mi-s)\\s*:\\s*Object$"; $text; 1)\
			 | Match regex:C1019("(?mi-s)\\s*:\\s*(?:4d|cs)\\.\\w*\\s*(?:/[/*].*)?$"; $text; 1)
			
			$type:=Is object:K8:27
			
			//______________________________________________________
		: (Position:C15(Parse formula:C1576("C_COLLECTION:C1488"); $text)=1)\
			 | Match regex:C1019("(?mi-s)\\s*:\\s*Collection\\s*(?:/[/*].*)?$"; $text; 1)
			
			$type:=Is collection:K8:32
			
			//______________________________________________________
		: (Position:C15(Parse formula:C1576("C_VARIANT:C1683"); $text)=1)\
			 | Match regex:C1019("(?mi-s)\\s*:\\s*Variant\\s*(?:/[/*].*)?$"; $text; 1)
			
			$type:=Is variant:K8:33
			
			//______________________________________________________
		: (Position:C15("var"; $text)=1)
			
			$type:=Is variant:K8:33
			
			//______________________________________________________
	End case 
	
	//==============================================================
Function getTypeFromRules($varName : Text)->$type : Integer
	
	var $pattern : Text
	var $o : Object
	
	For each ($o; This:C1470.settings.rules) While ($type=0)
		
		For each ($pattern; Split string:C1554($o.value; ";")) While ($type=0)
			
			If (Match regex:C1019($pattern; Delete string:C232($varName; 1; 1); 1))
				
				$type:=$o.type
				
			End if 
		End for each 
	End for each 
	
	//==============================================================
Function setType($type : Integer; $target : Object)
	
	var $o : Object
	
	If (Count parameters:C259>=2)
		
		$o:=$target
		
	Else 
		
		// A "If" statement should never omit "Else" 
		$o:=Form:C1466.current
		
	End if 
	
	$o.type:=$type
	$o.icon:=This:C1470.types[$o.type].icon
	
	//==============================================================
Function apply()
	
	var $buffer; $compilerDirectives; $method; $t : Text
	var $codeError; $i; $l; $length : Integer
	var $o; $type : Object
	var $c; $cc : Collection
	
	var $options : Object
	$options:=This:C1470.settings.options
	
	// MARK:PARAMETERS
	$c:=This:C1470.variables.query("parameter=true")
	$o:=This:C1470.lines.query("type = :1 OR type = :2"; "Function"; "Class constructor").pop()
	
	If ($c.length>0)\
		 | ($o#Null:C1517)
		
		$c:=$c.orderBy("order")
		
		If (This:C1470.class)
			
			If ($o#Null:C1517)
				
				$method:=String:C10($o.prefix)+$o.type+" "+String:C10($o.function)+" ("
				
				For each ($o; $c.query("order > 0"))
					
					$method+=(Num:C11($o.order)>1 ? ";" : "")+$o.value
					$method+=(This:C1470.types[$o.type].value#Is variant:K8:33) ? ":"+(($o.class#Null:C1517) ? String:C10($o.class) : This:C1470.types[$o.type].name) : ""
					
				End for each 
				
				$method:=$method+")"
				
				// * RETURN OF THE METHOD
				$o:=$c.query("order = 0").pop()
				
				If ($o#Null:C1517)
					
					If (This:C1470.types[$o.type].value=Is variant:K8:33)
						
						If ($o.code="C_@")\
							 | ($o.code="var @")
							
							$method+="\rvar "+$o.value
							
						Else 
							
							$method+=(Length:C16($o.value)>0 ? "->"+$o.value : "")
							
						End if 
						
					Else 
						
						If ($o.code="C_@")\
							 | ($o.code="var @")
							
							$method+="\rvar "+$o.value+":"+This:C1470.types[$o.type].name
							
						Else 
							
							$method+=(Length:C16($o.value)>0 ? "->"+$o.value : "")+":"\
								+($o.class#Null:C1517 ? String:C10($o.class) : This:C1470.types[$o.type].name)
							
						End if 
					End if 
				End if 
				
				$method+=String:C10(This:C1470.lines.query("type = :1 OR type = :2"; "Function"; "Class constructor").pop().comment)
				$method+="\r"
				
			End if 
			
		Else 
			
			If (This:C1470.lines.query("type = :1"; "#DECLARE").pop()=Null:C1517)
				
				// #DECLARE does not accept $1 ... $N as a parameter name, so we use the var keyword for parameters.
				For each ($o; $c)
					
					If ($o.class#Null:C1517)
						
						$method+="var "+$o.value+":"+$o.class+"\r"
						$compilerDirectives+="C_OBJECT:C1216("+This:C1470.name+";"+$o.value+")\r"
						
					Else 
						
						$method+="var "+$o.value+":"+This:C1470.types[$o.type].name+"\r"
						$compilerDirectives+="4d:C"+String:C10(This:C1470.types[$o.type].directive)+"("+This:C1470.name+";"+$o.value+")\r"
						
					End if 
				End for each 
				
				$method:=Delete string:C232($method; Length:C16($method); 1)
				
			Else 
				
				$method:="#DECLARE("
				
				For each ($o; $c.query("order > 0"))
					
					$method+=(";"*Num:C11($o.order>1))+$o.value
					
					If ($o.class#Null:C1517)
						
						$method+=":"+$o.class
						$compilerDirectives+="C_OBJECT:C1216("+This:C1470.name+";$"+String:C10($o.order)+")\r"
						
					Else 
						
						If ($o.type#Is variant:K8:33)
							
							$method+=":"+This:C1470.types[$o.type].name
							
						End if 
						
						$compilerDirectives+="4d:C"+String:C10(This:C1470.types[$o.type].directive)+"("+This:C1470.name+";$"+String:C10($o.order)+")\r"
						
					End if 
				End for each 
				
				$method+=")"
				
				// * RETURN OF THE METHOD
				$o:=$c.query("order = 0").pop()
				
				If ($o#Null:C1517)
					
					If ($o.code="C_@")
						
						$method+="\rvar "+$o.value+":"+This:C1470.types[$o.type].name+"\r"
						
					Else 
						
						$method+=(Length:C16($o.value)>0) ? "->"+$o.value+":" : ":"
						
						If ($o.class#Null:C1517)
							
							$method+=$o.class
							$compilerDirectives+="C_OBJECT:C1216("+This:C1470.name+";$0)\r"
							
						Else 
							
							$method+=This:C1470.types[$o.type].name
							$compilerDirectives+="4d:C"+String:C10(This:C1470.types[$o.type].directive)+"("+This:C1470.name+";$0)\r"
							
						End if 
					End if 
				End if 
				
				$method+=String:C10(This:C1470.lines.query("type = :1"; "#DECLARE").pop().comment)
				
			End if 
			
			// * COMPILER DIRECTIVES
			If (This:C1470.projectMethod)\
				 & (Bool:C1537($options.methodDeclaration))
				
				$method+="\r\r"+This:C1470.localized("If")+"(:C215)\r"\
					+Delete string:C232($compilerDirectives; Length:C16($compilerDirectives); 1)+"\r"\
					+This:C1470.localized("End if")
				
			End if 
		End if 
	End if 
	
	$method:=This:C1470.addNewLine($method)
	
	// MARK:LOCAL VARIABLES WITH SIMPLE TYPE
	$c:=This:C1470.variables.query("parameter=null & array=null & count>0 & class=null")
	
	If ($c.length>0)
		
		For each ($type; This:C1470.types.query("value!=null"))
			
			$cc:=New collection:C1472
			
			For each ($o; $c.query("type=:1"; $type.value))
				
				If ($o.type=Is object:K8:27)
					
					// Is it a class?
					If (This:C1470.classes.query("value=:1"; $o.value).pop()#Null:C1517)
						
						// Will be processed below
						$o.class:=This:C1470.classes.query("value=:1"; $o.value).pop().class
						
					Else 
						
						$cc.push($o.value)
						
					End if 
					
				Else 
					
					$cc.push($o.value)
					
				End if 
			End for each 
			
			If ($cc.length>0)
				
				// Limit the number of variables per declaration's line
				var $variablesNumberPerLine : Integer
				$variablesNumberPerLine:=Choose:C955($options.numberOfVariablePerLine=Null:C1517; 10; $options.numberOfVariablePerLine)
				
				If ($type.value=Is variant:K8:33)
					
					If ($cc.length>$variablesNumberPerLine)
						
						For ($i; 1; $cc.length; $variablesNumberPerLine)
							
							$method:=$method+"var "+$cc.slice(0; $variablesNumberPerLine).join("; ")+"\r"
							$cc.remove(0; $variablesNumberPerLine)
							
						End for 
					End if 
					
					If ($cc.length>0)
						
						$method:=$method+"var "+$cc.join("; ")+"\r"
						
					End if 
					
				Else 
					
					If ($cc.length>$variablesNumberPerLine)
						
						For ($i; 1; $cc.length; $variablesNumberPerLine)
							
							$method:=$method+"var "+$cc.slice(0; $variablesNumberPerLine).join("; ")+" :"+$type.name+"\r"
							$cc.remove(0; $variablesNumberPerLine)
							
						End for 
					End if 
					
					If ($cc.length>0)
						
						$method:=$method+"var "+$cc.join("; ")+" :"+$type.name+"\r"
						
					End if 
					
				End if 
			End if 
		End for each 
	End if 
	
	// MARK:LOCAL VARIABLES LINKED TO A CLASSE
	$c:=This:C1470.variables.query("parameter=null & array=null & count>0 & class!=null")
	
	If ($c.length>0)
		
		For each ($t; $c.distinct("class"))
			
			$method:=$method+"var "+$c.query("class=:1"; $t).extract("value").join("; ")+" :"+$t+"\r"
			
		End for each 
		
	End if 
	
	$method:=This:C1470.addNewLine($method)
	
	// MARK:ARRAYS
	$c:=This:C1470.variables.query("array=true & count>0 & static=false")
	
	If ($c.length>0)
		
		$method:=$method+("\r"*Num:C11(Length:C16($method)>0))
		
		For each ($type; This:C1470.types.query("arrayCommand!=null"))
			
			For each ($o; $c.query("type=:1"; $type.value))
				
				If ($o.dimension#Null:C1517)
					
					$method:=$method+Parse formula:C1576("4d:C"+String:C10($type.arrayCommand))\
						+"("+$o.value+(";0"*$o.dimension)+")\r"
					
				End if 
			End for each 
		End for each 
		
		// Remove the last carriage return
		$method:=Delete string:C232($method; Length:C16($method); 1)
		
	End if 
	
	If (Length:C16($method)>0)
		
		While ($method="@\r")
			
			$method:=Delete string:C232($method; Length:C16($method); 1)
			
		End while 
	End if 
	
	$method:=$method+"\r"
	
	If (This:C1470.class)
		
		$method:=$method+kCaret
		
	Else 
		
		// Look for the first empty or declaration line
		For each ($o; This:C1470.lines) While ($l#MAXLONG:K35:2)
			
			$t:=String:C10($o.type)
			$length:=Length:C16($method)
			
			Case of 
					
					//___________________
				: ($t="comment")
					
					$buffer:=$buffer+$o.code+"\r"
					$l:=Length:C16($buffer)
					$o.skip:=True:C214
					
					//___________________
				: ($t="empty")
					
					$method:=$buffer+Substring:C12($method; 1; $length-1)+"\r"+kCaret
					$l:=MAXLONG:K35:2
					
					//___________________
				Else 
					
					If ($l<=0)
						
						// Insert before
						$method:=$method+kCaret
						
					Else 
						
						$method:=$buffer+Substring:C12($method; 1; $length-1)+"\r"+kCaret
						
					End if 
					
					$l:=MAXLONG:K35:2
					
					//___________________
			End case 
		End for each 
		
		$method:=This:C1470.addNewLine($method)
		
	End if 
	
	// Restore the code
	For each ($o; This:C1470.lines)
		
		$t:=String:C10($o.type)
		
		Case of 
				
				//___________________
			: (Bool:C1537($o.skip))
				
				// <NOTHING MORE TO DO>
				
				//___________________
			: ($t="empty")
				
				If ($method="@\r\r")\
					 | ($method=("@"+kCaret+"\r"))
					
					// Skip
					
				Else 
					
					$method:=$method+"\r"
					
				End if 
				
				//________________________________________
			Else 
				
				$method:=$method+$o.code+"\r"
				
				//________________________________________
		End case 
	End for each 
	
	// Remove the last carriage return
	$method:=Delete string:C232($method; Length:C16($method); 1)
	
	If (Bool:C1537($options.trimEmptyLines))
		
		$codeError:=Rgx_SubstituteText("\\r{2,}"; "\r\r"; ->$method)
		$codeError:=Rgx_SubstituteText("(\\r*)$"; ""; ->$method)
		
	End if 
	
	This:C1470.method:=$method
	
	//==============================================================
Function addNewLine($text : Text)->$result : Text
	
	$result:=$text
	
	If (Length:C16($result)>0)
		
		If ($result=("@"+kCaret))
			
			$result:=$result+"\r"
			
		Else 
			
			While ($result#"@\r\r")
				
				$result:=$result+"\r"
				
			End while 
		End if 
	End if 
	
	//==============================================================
Function clairvoyant($text : Text; $line : Text)->$varType : Integer
	
	var $pattern; $t; $type : Text
	var $indx : Integer
	
	ARRAY LONGINT:C221($pos; 0)
	ARRAY LONGINT:C221($len; 0)
	
	$t:=Replace string:C233(Replace string:C233($text; "{"; "\\{"); "}"; "\\}")
	
	Case of 
			
			//______________________________________________________
		: (Match regex:C1019("(?m-si)(\\$\\w*):=((?:cs|4d)\\.\\w*)\\.new\\([^)]*\\)(?!\\.)"; $line; 1; $pos; $len))  // Class
			
			$varType:=Is object:K8:27
			
			// Keep class definition
			This:C1470.classes.push(New object:C1471(\
				"value"; Substring:C12($line; \
				$pos{1}; $len{1}); \
				"class"; Substring:C12($line; $pos{2}; $len{2})))
			
			//______________________________________________________
		: (Match regex:C1019("(?m-si)\\"+$t+":=\"[^\"]*\""\
			+"|"+Command name:C538(16)+"\\(\\"+$t+"\\)"; $line; 1))  // Length
			
			$varType:=Is text:K8:3
			
			//______________________________________________________
		: (Match regex:C1019("(?mi-s)\\"+$t+"[:><]?[=><]?\\d+[."+This:C1470.decimalSeparator+"]\\d+"; $line; 1))\
			 | (Match regex:C1019(":=\\s*"+Parse formula:C1576(":K30:1"); $line; 1))\
			 | (Match regex:C1019(":=\\s*"+Parse formula:C1576(":K30:2"); $line; 1))\
			 | (Match regex:C1019(":=\\s*"+Parse formula:C1576(":K30:3"); $line; 1))\
			 | (Match regex:C1019(":=\\s*"+Parse formula:C1576(":K30:4"); $line; 1))
			
			$varType:=Is real:K8:4
			
			//______________________________________________________
		: (Match regex:C1019("(?m-si)\\"+$t+"[:><]?[=><]?\\d+"; $line; 1))\
			 | (Match regex:C1019("(?mi-s)\\"+$t+"\\s\\?[?+-]\\s\\d*"; $line; 1))\
			 | (Match regex:C1019(":=\\s*"+Parse formula:C1576(":K35:1"); $line; 1))\
			 | (Match regex:C1019(":=\\s*"+Parse formula:C1576(":K35:2"); $line; 1))\
			 | (Match regex:C1019(":=\\s*"+Parse formula:C1576(":K35:3"); $line; 1))
			
			$varType:=Is longint:K8:6
			
			//______________________________________________________
		: (Match regex:C1019("(?m-si)\\"+$t+":=(?:"+Command name:C538(214)+"|"+Command name:C538(215)+")(?=$|\\(|(?:\\s*//)|(?:\\s*/\\*))"; $line; 1))
			
			$varType:=Is boolean:K8:9
			
			//______________________________________________________
		: (Match regex:C1019("(?m-si)\\"+$t+"\\."; $line; 1))\
			 | (Match regex:C1019("(?m-si):="+Parse formula:C1576("Form:C1466")+"[^.]"; $line; 1))
			
			$varType:=Is object:K8:27
			
			//______________________________________________________
		: (Match regex:C1019("(?m-si)\\"+$t+":=(?:!\\d+-\\d+-\\d+!)"; $line; 1))
			
			$varType:=Is date:K8:7
			
			//______________________________________________________
		: (Match regex:C1019("(?m-si)\\"+$t+":=(?:\\?\\d+:\\d+:\\d+\\?)"; $line; 1))
			
			$varType:=Is time:K8:8
			
			//______________________________________________________
		: (Match regex:C1019("(?mi-s)\\"+$t+":=->"; $line; 1))\
			 | (Match regex:C1019("(?mi-s)\\"+$t+"->"; $line; 1))
			
			$varType:=Is pointer:K8:14
			
			//______________________________________________________
		: (Match regex:C1019("(?m-si)(?:For|Boucle)\\s\\((?:[^;]*;\\s*){0,3}(\\"+$t+")"; $line; 1))
			
			$varType:=Is longint:K8:6
			
			//______________________________________________________
		: (Match regex:C1019("(?m-si)(?:If|Si|Not|Non)\\s*\\(\\"+$t+"\\)"; $line; 1))
			
			$varType:=Is boolean:K8:9
			
			//______________________________________________________
			
		Else   // Use gram.syntax
			
			For each ($type; This:C1470.gramSyntax) While ($varType=0)
				
				$indx:=Position:C15("_"; $type)
				
				If ($indx>0)
					
					For each ($pattern; This:C1470.gramSyntax[$type]) While ($varType=0)
						
						If (Match regex:C1019(Replace string:C233($pattern; "%"; $t); $line; 1))
							
							$varType:=Num:C11(Substring:C12($type; 1; $indx-1))
							
						End if 
					End for each 
					
				Else 
					
					For each ($pattern; This:C1470.gramSyntax[$type]) While ($varType=0)
						
						If (Match regex:C1019(Replace string:C233($pattern; "%"; $t)+"(?=$|\\(|(?:\\s*//)|(?:\\s*/\\*))"+")"; $line; 1))
							
							$varType:=Num:C11($type)
							
						End if 
					End for each 
				End if 
			End for each 
			
			//______________________________________________________
	End case 
	
	//==============================================================
Function loadGramSyntax()
	
	var $t : Text
	var $first; $i; $return : Integer
	var $patterns : Object
	var $file : 4D:C1709.File
	
	This:C1470.gramSyntax:=New object:C1471(\
		String:C10(Is object:K8:27); New collection:C1472; \
		String:C10(Is object:K8:27)+"_1"; New collection:C1472; \
		String:C10(Is boolean:K8:9); New collection:C1472; \
		String:C10(Is boolean:K8:9)+"_1"; New collection:C1472; \
		String:C10(Is longint:K8:6); New collection:C1472; \
		String:C10(Is longint:K8:6)+"_1"; New collection:C1472; \
		String:C10(Is text:K8:3); New collection:C1472; \
		String:C10(Is text:K8:3)+"_1"; New collection:C1472; \
		String:C10(Is real:K8:4); New collection:C1472; \
		String:C10(Is real:K8:4)+"_1"; New collection:C1472; \
		String:C10(Is collection:K8:32); New collection:C1472; \
		String:C10(Is collection:K8:32)+"_1"; New collection:C1472; \
		String:C10(Is pointer:K8:14); New collection:C1472; \
		String:C10(Is pointer:K8:14)+"_1"; New collection:C1472; \
		String:C10(Is date:K8:7); New collection:C1472; \
		String:C10(Is date:K8:7)+"_1"; New collection:C1472; \
		String:C10(Is time:K8:8); New collection:C1472; \
		String:C10(Is time:K8:8)+"_1"; New collection:C1472; \
		String:C10(Is BLOB:K8:12)+"_1"; New collection:C1472)
	
	$file:=Is macOS:C1572\
		 ? Folder:C1567(Application file:C491; fk platform path:K87:2).file("Contents/Resources/gram.4dsyntax")\
		 : File:C1566(Application file:C491; fk platform path:K87:2).parent.file("Resources/gram.4dsyntax")
	
	If ($file.exists)
		
		$patterns:=New object:C1471
		$patterns.affectation:="(?m-is)\\%:=(?:(?:#)(?=$|\\(|(?:\\s*//)|(?:\\s*/\\*))"
		$patterns.affectationSuite:="|(?:#)(?=$|\\(|(?:\\s*//)|(?:\\s*/\\*))"
		$patterns.first:="(?m-is)#\\s*\\(\\%"
		
		For each ($t; Split string:C1554($file.getText(); "\r"; sk trim spaces:K86:2))
			
			$i+=1
			$return:=-1
			$first:=-1
			
			//ASSERT($t#"\to <== Path to object : 42 : a ; L'")
			
			Case of 
					
					//______________________________________________________
				: (Match regex:C1019("(?m-si)^\\t@"; $t; 1))
					
					// The command entry is unused
					
					//______________________________________________________
				: (Match regex:C1019("(?m-si)^\\to\\s<==\\s"; $t; 1))\
					 & ($i#3)\
					 & ($i#4)
					
					$return:=Is object:K8:27
					
					//______________________________________________________
				: (Match regex:C1019("(?m-si)^\\tj\\s<==\\s"; $t; 1))
					
					$return:=Is collection:K8:32
					
					//______________________________________________________
				: (Match regex:C1019("(?m-si)^\\tB\\s<==\\s"; $t; 1))
					
					$return:=Is boolean:K8:9
					
					//______________________________________________________
				: (Match regex:C1019("(?m-si)^\\tL\\s<==\\s"; $t; 1))
					
					$return:=Is longint:K8:6
					
					//______________________________________________________
				: (Match regex:C1019("(?m-si)^\\tS\\s<==\\s"; $t; 1))
					
					$return:=Is text:K8:3
					
					//______________________________________________________
				: (Match regex:C1019("(?m-si)^\\ta\\d*\\s<==\\s"; $t; 1))
					
					$return:=Is text:K8:3
					
					//______________________________________________________
				: (Match regex:C1019("(?m-si)^\\tR\\s<==\\s"; $t; 1))
					
					$return:=Is real:K8:4
					
					//______________________________________________________
				: (Match regex:C1019("(?m-si)^\\tU\\s<==\\s"; $t; 1))
					
					$return:=Is pointer:K8:14
					
					//______________________________________________________
				: (Match regex:C1019("(?m-si)^\\tD\\s<==\\s"; $t; 1))
					
					$return:=Is date:K8:7
					
					//______________________________________________________
				: (Match regex:C1019("(?m-si)^\\tT\\s<==\\s"; $t; 1))
					
					$return:=Is time:K8:8
					
					//______________________________________________________
			End case 
			
			If ($return#-1)
				
				If (This:C1470.gramSyntax[String:C10($return)].length=0)
					
					This:C1470.gramSyntax[String:C10($return)].push(Replace string:C233($patterns.affectation; "#"; Parse formula:C1576("4d:C"+String:C10($i))))
					
				Else 
					
					This:C1470.gramSyntax[String:C10($return)][0]:=This:C1470.gramSyntax[String:C10($return)][0]\
						+Replace string:C233($patterns.affectationSuite; "#"; Parse formula:C1576("4d:C"+String:C10($i)))
					
				End if 
			End if 
			
			Case of 
					
					//______________________________________________________
				: (Match regex:C1019("(?m-si)^[^:]+\\s:\\s\\d+\\s:\\s(?:[^;/]*)?o"; $t; 1))
					
					$first:=Is object:K8:27
					
					//______________________________________________________
				: (Match regex:C1019("(?m-si)^[^:]+\\s:\\s\\d+\\s:\\s(?:[^;/]*)?j"; $t; 1))
					
					$first:=Is collection:K8:32
					
					//______________________________________________________
				: (Match regex:C1019("(?m-si)^[^:]+\\s:\\s\\d+\\s:\\s(?:[^;/]*)?a"; $t; 1))
					
					$first:=Is text:K8:3
					
					//______________________________________________________
				: (Match regex:C1019("(?m-si)^[^:]+\\s:\\s\\d+\\s:\\s(?:[^;/]*)?L"; $t; 1))
					
					$first:=Is longint:K8:6
					
					//______________________________________________________
				: (Match regex:C1019("(?m-si)^[^:]+\\s:\\s\\d+\\s:\\s(?:[^;/]*)?R"; $t; 1))
					
					$first:=Is real:K8:4
					
					//______________________________________________________
				: (Match regex:C1019("(?m-si)^[^:]+\\s:\\s\\d+\\s:\\s(?:[^;/]*)?D"; $t; 1))
					
					$first:=Is date:K8:7
					
					//______________________________________________________
				: (Match regex:C1019("(?m-si)^[^:]+\\s:\\s\\d+\\s:\\s(?:[^;/]*)?T"; $t; 1))
					
					$first:=Is time:K8:8
					
					//______________________________________________________
				: (Match regex:C1019("(?m-si)^[^:]+\\s:\\s\\d+\\s:\\s(?:[^;/]*)?B"; $t; 1))
					
					$first:=Is boolean:K8:9
					
					//______________________________________________________
				: (Match regex:C1019("(?m-si)^[^:]+\\s:\\s\\d+\\s:\\s(?:[^;/]*)?b"; $t; 1))
					
					$first:=Is BLOB:K8:12
					
					//________________________________________
			End case 
			
			If ($first#-1)
				
				This:C1470.gramSyntax[String:C10($first)+"_1"].push(Replace string:C233($patterns.first; "#"; Parse formula:C1576("4d:C"+String:C10($i))))
				
			End if 
		End for each 
	End if 
	
	//==============================================================
	// Remove the compilation directives
Function removeDirective
	
	var $len; $pos : Integer
	var $pattern : Text
	
	$pattern:="(?-msi)(\\R(?:If|Si)\\s*\\((?:False|Faux)\\)\\R(?:C_.*\\("+This:C1470.name+";.*\\)\\R)*(?:End if|Fin de si)\\s*\\R)"
	
	If (This:C1470.withSelection)
		
		If (Match regex:C1019($pattern; This:C1470.highlighted; 1; $pos; $len))
			
			This:C1470.highlighted:=Delete string:C232(This:C1470.highlighted; $pos; $len)
			
		End if 
		
	Else 
		
		If (Match regex:C1019($pattern; This:C1470.method; 1; $pos; $len))
			
			This:C1470.method:=Delete string:C232(This:C1470.method; $pos; $len)
			
		End if 
	End if 
	