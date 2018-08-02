SELECT prod_parent.parentid AS [Parent ID],
prod_child.childid AS [Child ID],
ebay.SKU AS [SKU],
ebay.eTITLE AS Title,
CASE 
WHEN prod_child.onsale = 1 AND prod_child.saleprice <= 399 AND VAN_KEY IN(2, 5) THEN FLOOR((prod_child.saleprice) + 60)- 0.06
WHEN prod_child.onsale = 1 AND prod_child.saleprice > 399 AND VAN_KEY IN(2, 5) THEN FLOOR(prod_child.saleprice + 30) - 0.06
WHEN prod_child.onoffer = 1 AND prod_child.offerprice <= 399 AND VAN_KEY IN(2, 5) THEN FLOOR((prod_child.offerprice) + 60)- 0.06
WHEN prod_child.onoffer = 1 AND prod_child.offerprice > 399 AND VAN_KEY IN(2, 5) THEN FLOOR(prod_child.offerprice + 30) - 0.06
WHEN  prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price <= 399 AND VAN_KEY IN(2, 5) THEN FLOOR((prod_child.price) + 60)- 0.06
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price > 399 AND VAN_KEY IN(2, 5) THEN FLOOR(prod_child.price + 30) - 0.06
WHEN prod_child.onsale = 1 AND VAN_KEY = 1 THEN FLOOR((prod_child.saleprice) + 10)- 0.06
WHEN prod_child.onoffer = 1 AND VAN_KEY = 1 THEN FLOOR((prod_child.offerprice) + 10)- 0.06
WHEN  prod_child.onsale = 0 AND prod_child.onoffer = 0 AND VAN_KEY = 1 THEN FLOOR((prod_child.price) + 10)- 0.06
ELSE FLOOR(prod_child.price) - 0.06
END AS [BIN Price],
CASE 
WHEN prod_child.onsale = 1 AND prod_child.saleprice <= 399 AND prod_child.saleprice < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 60,'.00')
WHEN prod_child.onsale = 1 AND prod_child.saleprice > 399 AND prod_child.saleprice < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp + 30),'.00')
WHEN prod_child.onsale = 1 AND prod_child.saleprice <= 399 AND prod_child.saleprice >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.saleprice + (prod_child.saleprice * 0.30) + 60),'.00')
WHEN prod_child.onsale = 1 AND prod_child.saleprice > 399 AND prod_child.saleprice >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.saleprice + (prod_child.saleprice * 0.30) + 30),'.00')
WHEN prod_child.onoffer = 1 AND prod_child.offerprice <= 399 AND prod_child.offerprice < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 60,'.00')
WHEN prod_child.onoffer = 1 AND prod_child.offerprice > 399 AND prod_child.offerprice < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 30,'.00')
WHEN prod_child.onoffer = 1 AND prod_child.offerprice <= 399 AND prod_child.offerprice >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.offerprice + (prod_child.offerprice * 0.30)) + 60,'.00')
WHEN prod_child.onoffer = 1 AND prod_child.offerprice > 399 AND prod_child.offerprice >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.offerprice + (prod_child.offerprice * 0.30) + 30),'.00')
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price <= 399 AND prod_child.price < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 60,'.00')
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price > 399 AND prod_child.price < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp + 30),'.00')
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price <= 399 AND prod_child.price >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.price + (prod_child.price * 0.3)) + 60,'.00')
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price > 399 AND prod_child.price >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.price + (prod_child.price * 0.3) + 30),'.00')
WHEN prod_child.onsale = 1 AND prod_child.saleprice < prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.rrp) + 10,'.00')
WHEN prod_child.onsale = 1 AND prod_child.saleprice >= prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.saleprice + (prod_child.saleprice * 0.30) + 10),'.00')
WHEN prod_child.onoffer = 1 AND prod_child.offerprice < prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.rrp) + 10,'.00')
WHEN prod_child.onoffer = 1 AND prod_child.offerprice >= prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.offerprice + (prod_child.offerprice * 0.30) + 10),'.00')
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price < prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.rrp) + 10,'.00')
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price >= prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.price + (prod_child.price * 0.3) + 10),'.00')
ELSE CONCAT(FLOOR(prod_child.price + (prod_child.price * 0.3)) + VAN_KEY.PRICE,'.00')
END AS [RRP Price],
CONCAT(
CASE
WHEN c2.CatID = 9
THEN
CONCAT(
'<p style="font-size:16px;text-align:justify">The ',LOWER(prod_parent.range_name),' ',
CASE
WHEN c1.CatID = 80	 THEN 	'bidet'
WHEN c1.CatID = 83	 THEN 	'close coupled toilet'
WHEN c1.CatID = 84	 THEN 	'back to wall toilet'
WHEN c1.CatID = 85	 THEN 	'wall hung toilet'
WHEN c1.CatID = 86	 THEN 	'toilet seat'
WHEN c1.CatID = 230	 THEN 	'traditional toilet'
END,
' is made in ',LOWER(prod_child.colour),' ',LOWER(ebay.Material),
' in a ',CASE WHEN prod_child.[modern traditional] = 'M' THEN 'modern ' WHEN prod_child.[modern traditional] = 'T' THEN 'traditional ' ELSE 'modern' END,
' design and manufactured by ',LOWER(supplier2),', makes it a perfect addition to any bathroom and comes with a ',ebay.Guarantee,'.</p>',
'|
<tr><td><strong>BRAND:</strong></td>',
'<td>',UPPER(supplier2),'</td></tr>',
'<tr><td><strong>NAME:&nbsp;&nbsp;</strong></td>',
'<td>',CASE WHEN ebay.[Range name] != '' THEN ebay.[Range name] ELSE UPPER(prod_parent.range_name) END,'</td><tr>',
'<tr><td><strong>MATERIAL:<strong></td>',
'<td>',UPPER(ebay.Material),'</td><tr>',
'<tr><td><strong>PAN HEIGHT:</strong></td>',
'<td>',UPPER(ebay.[Pan Height]),'</td></tr>',
'<tr><td><strong>OPTIONS:&nbsp;&nbsp;<strong></td>',
'<td>',UPPER(ebay.Options),'</td></tr>',
'<tr><td><strong>INCLUDED:</strong></td>',
'<td>',UPPER(ebay.Included),'</td></tr>',
'<tr><td><strong>EXCLUDED:</strong></td>',
'<td>',UPPER(ebay.Excluded),'</td></tr>',
'<tr><td><strong>TOILET TYPE:</strong></td>',
'<td>',CASE WHEN c1.Name = 'Semi Recess Basins' THEN 'SEMI RECESSED BASINS' ELSE UPPER(c1.Name) END,'</td></tr>',
'<tr><td><strong>GUARANTEE:<strong></td>',
'<td>',UPPER(ebay.Guarantee),'</td><tr></table><br>')
WHEN c1.CatID IN(114, 107, 108, 208, 204) THEN CONCAT(
'<p style="font-size:16px;text-align:justify">This ',ebay.Brand,' ', prod_child.height, ' ', ebay.[Range name],
' Enclosure comes in a ',LOWER(CASE WHEN prod_child.[modern traditional] = 'M' THEN 'Modern ' ELSE 'Traditional ' END),LOWER(ebay.[Main colour]),
' and ',LOWER(ebay.Material),' design making it a perfect and relevant replacement or addition to any bathroom.</p>',
'|<tr><td><strong>BRAND:</strong></td>',
'<td>',UPPER(ebay.Brand),'</td></tr>',
'<tr><td><strong>NAME:&nbsp;&nbsp;</strong></td>',
'<td>',ebay.[Range name],'</td></tr>',
'<tr><td><strong>GUARANTEE:<strong></td>',
'<td>',UPPER(ebay.Guarantee),'</td></tr>',
'<tr><td><strong>FEATURES:<strong></td>',
'<td>',UPPER(ebay.Features),'</td></tr></table><br>') 
WHEN c1.CatID IN(149, 161, 66, 148, 147, 150) THEN CONCAT(
'<p style="font-size:16px;text-align:justify">This ', ebay.Type, ' comes in a ', ebay.[Main colour], ' finish with a ', (CASE WHEN prod_child.[modern traditional] = 'M' THEN 'modern' ELSE 'traditional' END),
' design making it a perfect and relevant replacement or addition to any bathroom, cloakroom, loft or en-suite. It is manufactured by ', ebay.Brand, ' and comes with a ', ebay.Guarantee,' guarantee.</p>',
'|<tr><td><strong>BRAND:</strong></td>',
'<td>',UPPER(ebay.Brand),'</td></tr>',
'<tr><td><strong>GUARANTEE:<strong></td>',
'<td>',UPPER(ebay.Guarantee),'</td></tr>') 
WHEN c1.CatID IN(56, 37) THEN CONCAT(
'<p style="font-size:16px;text-align:justify">This ',ebay.Shape, ' ', ebay.Type, ' comes in a ', ebay.[Main colour], ' ', ebay.Colour, ' finish in a ', (CASE WHEN prod_child.[modern traditional] = 'M' THEN 'modern' ELSE 'traditional' END),
' design making it a perfect and relevant replacement or addition to any bathroom, cloakroom, loft or en-suite. It is manufactured by ', ebay.Brand, ' and comes with a ', ebay.Guarantee,' guarantee.</p>',
'|<tr><td><strong>BRAND:</strong></td>',
'<td>',UPPER(ebay.Brand),'</td></tr>',
'<tr><td><strong>GUARANTEE:<strong></td>',
'<td>',UPPER(ebay.Guarantee),'</td></tr>',
'<tr><td><strong>FEATURES:<strong></td>',
'<td>',UPPER(ebay.Features),'</td></tr></table><br>') 
WHEN c2.CatID = 196
THEN
CONCAT(
'<p style="font-size:16px;text-align:justify">The ',LOWER(prod_parent.range_name),' ',
CASE
WHEN c1.CatID = 81	 THEN 	'basin and pedestal'
WHEN c1.CatID = 166	 THEN 	'wall hung basin'
WHEN c1.CatID = 167	 THEN 	'countertop basin'
WHEN c1.CatID = 168	 THEN 	'semi recessed basin'
WHEN c1.CatID = 182	 THEN 	'fully recessed basin'
WHEN c1.CatID = 217	 THEN 	'stone bathroom basin'
END,
' is made in ',LOWER(prod_child.colour),' ',LOWER(ebay.Material),
' in a ',CASE WHEN prod_child.[modern traditional] = 'M' THEN 'modern ' WHEN prod_child.[modern traditional] = 'T' THEN 'traditional ' ELSE 'modern' END,
' design and manufactured by ',LOWER(supplier2),', makes it a perfect addition to any bathroom, cloakroom or en-suite and comes with a ',ebay.Guarantee,'.</p>',
'|
<tr><td><strong>BRAND:</strong></td>',
'<td>',UPPER(supplier2),'</td></tr>',
'<tr><td><strong>NAME:&nbsp;&nbsp;</strong></td>',
'<td>',CASE WHEN ebay.[Range name] != '' THEN ebay.[Range name] ELSE prod_parent.range_name END,'</td></tr>',
'<tr><td><strong>MATERIAL:<strong></td>',
'<td>',UPPER(ebay.Material),'</td></tr>',
'<tr><td><strong>TAP HOLE:</strong></td>',
'<td>',UPPER(ebay.[Tap Hole]),'</td></tr>',
'<tr><td><strong>OVERLOW:&nbsp;&nbsp;<strong></td>',
'<td>',UPPER(ebay.Overflow),'</td></tr>',
'<tr><td><strong>INCLUDED:</strong></td>',
'<td>',UPPER(ebay.Included),'</td></tr>',
'<tr><td><strong>EXCLUDED:</strong></td>',
'<td>',UPPER(ebay.Excluded),'</td></tr>',
'<tr><td><strong>SINK TYPE:</strong></td>',
'<td>',CASE WHEN c1.Name = 'Semi Recess Basins' THEN 'SEMI RECESSED BASINS' ELSE UPPER(c1.Name) END,'</td></tr>',
'<tr><td><strong>GUARANTEE:<strong></td>',
'<td>',UPPER(ebay.Guarantee),'</td><tr></table><br>')
WHEN c1.CatID IN (41) THEN 
CONCAT(
'<p style="font-size:16px;text-align:justify">This ',ebay.Brand, ' ', ebay.Material, ' ', ebay.[Range name],' ', ebay.Shape, ' ', ebay.Side, ' ', ebay.Type,
' comes in a modern ', lower(ebay.[Main colour]), ' finish design making it a perfect and relevant replacement or addition to any bathroom.</p>',
'|<tr><td><strong>BRAND:</strong></td>',
'<td>',UPPER(ebay.Brand),'</td></tr>',
'<tr><td><strong>NAME:&nbsp;&nbsp;</strong></td>',
'<td>',ebay.[Range name],'</td></tr>',
'<tr><td><strong>GUARANTEE:<strong></td>',
'<td>',UPPER(ebay.Guarantee),'</td></tr>',
'<tr><td><strong>FEATURES:<strong></td>',
'<td>',UPPER(ebay.Features),'</td></tr></table><br>')
WHEN c2.CatID IN (11, 6, 7, 64, 1)
THEN
CONCAT(
'<p style="font-size:16px;text-align:justify">This model of the ',ebay.[Range name],
' bathroom range is ',LOWER(ebay.Side),' and comes in ',LOWER(ebay.[Main colour]),
' with a ',LOWER(ebay.Colour),' finish in a classic ',CASE WHEN prod_child.[modern traditional] = 'M' THEN 'modern ' WHEN prod_child.[modern traditional] = 'T' THEN 'traditional' ELSE 'modern' END,
' design making it a perfect and relevant replacement or addition to any bathroom, cloakroom or en-suite. It is manufactured in the ',ebay.ManufacturedIn,' by ', ebay.Brand,' and comes with a ',ebay.Guarantee,'.</p>',
'|
<tr><td><strong>BRAND:</strong></td>',
'<td>',UPPER(ebay.Brand),'</td></tr>',
'<tr><td><strong>NAME:&nbsp;&nbsp;</strong></td>',
'<td>',ebay.[Range name],'</td></tr>',
'<tr><td><strong>GUARANTEE:<strong></td>',
'<td>',UPPER(ebay.Guarantee),'</td></tr>',
'<tr><td><strong>FEATURES:<strong></td>',
'<td>',UPPER(ebay.Features),'</td></tr></table><br>')
ELSE ''
END,
CASE WHEN c2.CatID IN (11, 6, 7, 64, 1, 9, 196) or c1.CatID IN(114, 107, 108, 208, 204, 56, 37, 149, 161, 66, 148, 147, 150) THEN CONCAT(
'|<tr><td style="text-decoration: line-through;color:red"><strong>RRP:</strong> &pound;',
CASE 
WHEN prod_child.onsale = 1 AND prod_child.saleprice <= 399 AND prod_child.saleprice < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 60,'.00')
WHEN prod_child.onsale = 1 AND prod_child.saleprice > 399 AND prod_child.saleprice < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 30,'.00')
WHEN prod_child.onsale = 1 AND prod_child.saleprice <= 399 AND prod_child.saleprice >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.saleprice + (prod_child.saleprice * 0.30) + 60),'.00')
WHEN prod_child.onsale = 1 AND prod_child.saleprice > 399 AND prod_child.saleprice >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.saleprice + (prod_child.saleprice * 0.30) + 30),'.00')
WHEN prod_child.onoffer = 1 AND prod_child.offerprice <= 399 AND prod_child.offerprice < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 60,'.00')
WHEN prod_child.onoffer = 1 AND prod_child.offerprice > 399 AND prod_child.offerprice < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 30,'.00')
WHEN prod_child.onoffer = 1 AND prod_child.offerprice <= 399 AND prod_child.offerprice >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.offerprice + (prod_child.offerprice * 0.30)) + 60,'.00')
WHEN prod_child.onoffer = 1 AND prod_child.offerprice > 399 AND prod_child.offerprice >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.offerprice + (prod_child.offerprice * 0.30)) + 30,'.00')
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price <= 399 AND prod_child.price < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 60,'.00')
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price > 399 AND prod_child.price < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 30,'.00')
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price <= 399 AND prod_child.price >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.price + (prod_child.price * 0.3)) + 60,'.00')
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price > 399 AND prod_child.price >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.price + (prod_child.price * 0.3)) + 30,'.00')
WHEN prod_child.onsale = 1 AND prod_child.saleprice < prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.rrp) + 10,'.00')
WHEN prod_child.onsale = 1 AND prod_child.saleprice >= prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.saleprice + (prod_child.saleprice * 0.30) + 10),'.00')
WHEN prod_child.onoffer = 1 AND prod_child.offerprice < prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.rrp) + 10,'.00')
WHEN prod_child.onoffer = 1 AND prod_child.offerprice >= prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.offerprice + (prod_child.offerprice * 0.30)) + 10,'.00')
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price < prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.rrp) + 10,'.00')
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price >= prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.price + (prod_child.price * 0.3)) + 10,'.00')
ELSE CONCAT(FLOOR(prod_child.price + (prod_child.price * 0.3)) + [Delivery Service 1 Price],'.00')
END,'</td>',
'<td style="color:green">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>OUR PRICE:</strong> &pound;',
CASE 
WHEN prod_child.onsale = 1 AND prod_child.saleprice <= 399 AND VAN_KEY IN(2, 5) THEN FLOOR((prod_child.saleprice) + 60)- 0.06
WHEN prod_child.onsale = 1 AND prod_child.saleprice > 399 AND VAN_KEY IN(2, 5) THEN FLOOR(prod_child.saleprice) + 30 - 0.06
WHEN prod_child.onoffer = 1 AND prod_child.offerprice <= 399 AND VAN_KEY IN(2, 5) THEN FLOOR((prod_child.offerprice) + 60)- 0.06
WHEN prod_child.onoffer = 1 AND prod_child.offerprice > 399 AND VAN_KEY IN(2, 5) THEN FLOOR(prod_child.offerprice) + 30 - 0.06
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price <= 399 AND VAN_KEY IN(2, 5) THEN FLOOR((prod_child.price) + 60)- 0.06
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price > 399 AND VAN_KEY IN(2, 5) THEN FLOOR(prod_child.price) + 30 - 0.06
WHEN prod_child.onsale = 1 AND prod_child.saleprice > 399 AND VAN_KEY IN(2, 5) THEN FLOOR(prod_child.saleprice) + 30 - 0.06
WHEN prod_child.onoffer = 1 AND prod_child.offerprice <= 399 AND VAN_KEY IN(2, 5) THEN FLOOR((prod_child.offerprice) + 60)- 0.06
WHEN prod_child.onsale = 1 AND VAN_KEY = 1 THEN FLOOR(prod_child.saleprice) + 10 - 0.06
WHEN prod_child.onoffer = 1 AND VAN_KEY = 1 THEN FLOOR((prod_child.offerprice) + 10)- 0.06
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND VAN_KEY = 1 THEN FLOOR((prod_child.price) + 10)- 0.06
ELSE FLOOR(prod_child.price) - 0.06
END,'</td>',
'<td  style="color:#0284B6">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>YOU SAVE:</strong> &pound;',
CASE 
WHEN prod_child.onsale = 1 AND prod_child.saleprice <= 399 AND prod_child.saleprice < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 60,'.00')
WHEN prod_child.onsale = 1 AND prod_child.saleprice > 399 AND prod_child.saleprice < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 30,'.00')
WHEN prod_child.onsale = 1 AND prod_child.saleprice <= 399 AND prod_child.saleprice >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.saleprice + (prod_child.saleprice * 0.30)) + 60,'.00')
WHEN prod_child.onsale = 1 AND prod_child.saleprice > 399 AND prod_child.saleprice >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.saleprice + (prod_child.saleprice * 0.30) + 30),'.00')
WHEN prod_child.onoffer = 1 AND prod_child.offerprice <= 399 AND prod_child.offerprice < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 60,'.00')
WHEN prod_child.onoffer = 1 AND prod_child.offerprice > 399 AND prod_child.offerprice < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 30,'.00')
WHEN prod_child.onoffer = 1 AND prod_child.offerprice <= 399 AND prod_child.offerprice >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.offerprice + (prod_child.offerprice * 0.30)) + 60,'.00')
WHEN prod_child.onoffer = 1 AND prod_child.offerprice > 399 AND prod_child.offerprice >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.offerprice + (prod_child.offerprice * 0.30) + 30),'.00')
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price <= 399 AND prod_child.price < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 60,'.00')
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price > 399 AND prod_child.price < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 30,'.00')
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price <= 399 AND prod_child.price >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.price + (prod_child.price * 0.3)) + 60,'.00')
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price > 399 AND prod_child.price >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.price + (prod_child.price * 0.3)) + 30,'.00')
WHEN prod_child.onsale = 1 AND prod_child.saleprice < prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.rrp) + 10,'.00')
WHEN prod_child.onsale = 1 AND prod_child.saleprice >= prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.saleprice + (prod_child.saleprice * 0.30)) + 10,'.00')
WHEN prod_child.onoffer = 1 AND prod_child.offerprice < prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.rrp) + 10,'.00')
WHEN prod_child.onoffer = 1 AND prod_child.offerprice >= prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.offerprice + (prod_child.offerprice * 0.30)) + 10,'.00')
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 10,'.00')
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.price + (prod_child.price * 0.3)) + 10,'.00')
ELSE CONCAT(FLOOR(prod_child.price + (prod_child.price * 0.3)) + [Delivery Service 1 Price],'.00')
END - 
CASE 
WHEN prod_child.onsale = 1 AND prod_child.saleprice <= 399 AND VAN_KEY IN(2, 5) THEN FLOOR((prod_child.saleprice) + 60)- 0.06
WHEN prod_child.onsale = 1 AND prod_child.saleprice > 399 AND VAN_KEY IN(2, 5) THEN FLOOR(prod_child.saleprice) + 30 - 0.06
WHEN prod_child.onoffer = 1 AND prod_child.offerprice <= 399 AND VAN_KEY IN(2, 5) THEN FLOOR((prod_child.offerprice) + 60)- 0.06
WHEN prod_child.onoffer = 1 AND prod_child.offerprice > 399 AND VAN_KEY IN(2, 5) THEN FLOOR(prod_child.offerprice) + 30 - 0.06
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price <= 399 AND VAN_KEY IN(2, 5) THEN FLOOR((prod_child.price) + 60)- 0.06
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price > 399 AND VAN_KEY IN(2, 5) THEN FLOOR(prod_child.price) + 30 - 0.06
WHEN prod_child.onsale = 1 AND VAN_KEY = 1 THEN FLOOR(prod_child.saleprice) + 10 - 0.06
WHEN prod_child.onoffer = 1 AND VAN_KEY = 1 THEN FLOOR((prod_child.offerprice) + 10)- 0.06
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND VAN_KEY = 1 THEN FLOOR((prod_child.price) + 10)- 0.06
ELSE FLOOR(prod_child.price) - 0.06
END,'</td></tr></table>') ELSE '' END) AS Description,
CASE WHEN ebay.Image1 !='' AND ebay.Image1 IS NOT NULL THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image1) ELSE '' END AS Image1,
CASE WHEN ebay.Image2 !='' AND ebay.Image2 IS NOT NULL THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image2) ELSE '' END AS Image2,
CASE WHEN ebay.Image3 !='' AND ebay.Image3 IS NOT NULL THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image3) ELSE '' END AS Image3,
CASE WHEN ebay.Image4 !='' AND ebay.Image4 IS NOT NULL THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image4) ELSE '' END AS Image4,
CASE WHEN ebay.Image5 !='' AND ebay.Image5 IS NOT NULL  THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image5) ELSE '' END AS Image5,
CASE WHEN ebay.Image6 !='' AND ebay.Image6 IS NOT NULL THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image6) ELSE '' END AS Image6,
CASE WHEN ebay.Image7 !='' AND ebay.Image7 IS NOT NULL THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image7) ELSE '' END AS Image7,
CASE WHEN ebay.Image8 !='' AND ebay.Image8 IS NOT NULL THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image8) ELSE '' END AS Image8,
CASE WHEN ebay.Image9 !='' AND ebay.Image9 IS NOT NULL THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image9) ELSE '' END AS Image9,
CASE WHEN ebay.Image10 !='' AND ebay.Image10 IS NOT NULL THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image10) ELSE '' END AS Image10,
CASE WHEN ebay.Image11 !='' AND ebay.Image11 IS NOT NULL THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image11) ELSE '' END AS Image11,
CASE WHEN ebay.eDrawing !='' AND ebay.eDrawing IS NOT NULL THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.eDrawing) ELSE '' END AS Image12,
CASE 
WHEN prod_parent.displayproduct = 0 THEN '0'
WHEN prod_child.displayproduct = 0 THEN '0'
WHEN prod_child.onsale = 1 AND prod_child.saleprice = 0 THEN '0'
WHEN prod_child.onoffer = 1 AND prod_child.offerprice = 0 THEN '0'
WHEN prod_child.onoffer = 0 AND prod_child.onsale = 0 AND prod_child.price = 0 THEN '0'
ELSE '1' 
END AS QTY,
CASE 
WHEN VAN_KEY.VAN_KEY = 2 or VAN_KEY.VAN_KEY = 5 THEN 'UK_OtherCourier' 
WHEN VAN_KEY.VAN_KEY = 1 THEN 'UK_Parcelforce48'
ELSE ebay.[Delivery Service 1 Name] END AS [Delivery Service 1 Name],
0 AS [Delivery Service 1 Price],
0 AS [Delivery Service 1 Add Price],
CASE 
WHEN VAN_KEY.VAN_KEY = 5 THEN 'UK_OtherCourier24'
WHEN VAN_KEY.VAN_KEY = 2 THEN 'UK_OtherCourier24'
WHEN VAN_KEY.VAN_KEY = 1 THEN 'UK_ParcelForce24' END AS [Delivery Service 2 Name],
10 AS [Delivery Service 2 Price] ,
10 AS [Delivery Service 2 Add Price],
'UK_CollectInPerson' AS [Delivery Service 3 Name],
0 AS [Delivery Service 3 Price],
Tag AS [Tag]
from prod_parent
JOIN VAN_KEY ON prod_parent.van = VAN_KEY.VAN_KEY
JOIN categories c1 ON prod_parent.prod_parent_new_cat = c1.CatID
INNER JOIN categories c2 ON c1.ParentID = c2.CatID
FULL JOIN prod_child ON prod_parent.parentid = prod_child.child_parentid
FULL JOIN [intranet-test].[dbo].[ebayTable] ebay ON prod_child.childid = ebay.eChildID
WHERE eStatus='LIVE' 
ORDER BY ebay.SKU