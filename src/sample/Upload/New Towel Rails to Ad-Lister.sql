SELECT 

-- ADDITIONAL COLUMNS TO DISPLAY PARENT AND CHILD IDs AND PRODUCT AVAILABILITY, NOT REQUIRED FOR AD-LISTER (UNCOMMENT TO SEE)
--prod_parent.parentid AS [Parent ID],
--prod_child.childid AS [Child ID],
--prod_parent.displayproduct AS [Parent Display],
--prod_child.displayproduct AS [Child Display],

------------------------------------------------------------------------------------------------------------------

ebay.SKU AS [SKU],

-- EBAY TITLE. IF THE TITLE IS NOT IN EBAY TABLE --> ADDS 'EDIT TITLE___' PLUS ORIGINAL BC PRODUCT TITLE TO BE EDITED
CASE
WHEN ebay.eTitle != '' THEN ebay.eTitle
ELSE CONCAT('EDIT TITLE___',prod_parent.prodtitl)
END AS Title,

------------------------------------------------------------------------------------------------------------------
-- BUY IT NOW PRICE ROUNDED DOWN PLUS SHIPPING COST (IF APPLICABLE) MINUS 6 PENCE 
CASE 
-- VAN_KEY = 2 OR 5:

--WHEN PRODUCT ON SALE AND SALE PRICE BELOW OR EQUAL 399 AND VAN_KEY = 2 (Pallet) --> ROUNDS IT DOWN, ADDS SHIPPING COST AND TAKES OFF 6 PENCE
WHEN prod_child.onsale = 1 AND prod_child.saleprice <= 399 AND VAN_KEY IN(2, 5) THEN FLOOR((prod_child.saleprice) + 60)- 0.06
--WHEN PRODUCT ON SALE AND SALE PRICE OVER 399 AND VAN_KEY = 2 (Pallet) --> ROUNDS IT DOWN AND TAKES OFF 6 PENCE
WHEN prod_child.onsale = 1 AND prod_child.saleprice > 399 AND VAN_KEY IN(2, 5) THEN FLOOR(prod_child.saleprice + 30) - 0.06

--WHEN PRODUCT ON OFFER AND OFFER PRICE BELOW OR EQUAL 399 --> ROUNDS IT DOWN, ADDS SHIPPING COST AND TAKES OFF 6 PENCE
--WHEN prod_child.onoffer = 1 AND prod_child.offerprice <= 399 THEN FLOOR((prod_child.offerprice) + [Delivery Service 1 Price])- 0.06
WHEN prod_child.onoffer = 1 AND prod_child.offerprice <= 399 AND VAN_KEY IN(2, 5) THEN FLOOR((prod_child.offerprice) + 60)- 0.06
--WHEN PRODUCT ON OFFER AND OFFER PRICE OVER 399 --> ROUNDS IT DOWN AND TAKES OFF 6 PENCE
WHEN prod_child.onoffer = 1 AND prod_child.offerprice > 399 AND VAN_KEY IN(2, 5) THEN FLOOR(prod_child.offerprice + 30) - 0.06

--WHEN PRODUCT NOT ON SALE AND NOT ON OFFER AND ORIGINAL PRICE BELOW OR EQUAL 399 --> ROUNDS IT DOWN, ADDS SHIPPING COST AND TAKES OFF 6 PENCE
WHEN  prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price <= 399 AND VAN_KEY IN(2, 5) THEN FLOOR((prod_child.price) + 60)- 0.06
--WHEN PRODUCT NOT ON SALE AND NOT ON OFFER AND ORIGINAL PRICE OVER 399 --> ROUNDS IT DOWN AND TAKES OFF 6 PENCE
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price > 399 AND VAN_KEY IN(2, 5) THEN FLOOR(prod_child.price + 30) - 0.06

-- VAN_KEY = 1:
-- WHEN ON SALE AND VAN_KEY = 1 (PARCELFORCE)
WHEN prod_child.onsale = 1 AND VAN_KEY = 1 THEN FLOOR((prod_child.saleprice) + 10)- 0.06

--WHEN PRODUCT ON OFFER AND VAN_KEY = 1
WHEN prod_child.onoffer = 1 AND VAN_KEY = 1 THEN FLOOR((prod_child.offerprice) + 10)- 0.06

--WHEN PRODUCT NOT ON SALE AND NOT ON OFFER AND VAN_KEY = 1
WHEN  prod_child.onsale = 0 AND prod_child.onoffer = 0 AND VAN_KEY = 1 THEN FLOOR((prod_child.price) + 10)- 0.06

ELSE FLOOR(prod_child.price) - 0.06
END AS [BIN Price],

------------------------------------------------------------------------------------------------------------------

-- RRP PRICE
CASE 
--WHEN PRODUCT ON SALE AND SALE PRICE BELOW OR EQUAL 399 AND SALE PRICE LOVER THAN RRP PRICE --> TAKES PRODUCT RRP, ROUNDS IT DOWN, ADDS SHIPPING COST AND .00 AT THE END
WHEN prod_child.onsale = 1 AND prod_child.saleprice <= 399 AND prod_child.saleprice < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 60,'.00')
--WHEN PRODUCT ON SALE AND SALE PRICE OVER 399 AND SALE PRICE LOVER THAN RRP PRICE --> TAKES PRODUCT RRP, ROUNDS IT DOWN, ADDS .00 AT THE END
WHEN prod_child.onsale = 1 AND prod_child.saleprice > 399 AND prod_child.saleprice < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp + 30),'.00')

--WHEN PRODUCT ON SALE AND SALE PRICE BELOW OR EQUAL 399 AND SALE PRICE EQUAL OR HIGHER THAN RRP PRICE --> TAKES PRODUCT SALE PRICE, ROUNDS IT DOWN, ADDS 30%, ADDS SHIPPING COST AND .00 AT THE END
WHEN prod_child.onsale = 1 AND prod_child.saleprice <= 399 AND prod_child.saleprice >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.saleprice + (prod_child.saleprice * 0.30) + 60),'.00')
--WHEN PRODUCT ON SALE AND SALE PRICE OVER 399 AND SALE PRICE EQUAL OR HIGHER THAN RRP PRICE --> TAKES PRODUCT SALE PRICE, ROUNDS IT DOWN, ADDS 30% AND .00 AT THE END
WHEN prod_child.onsale = 1 AND prod_child.saleprice > 399 AND prod_child.saleprice >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.saleprice + (prod_child.saleprice * 0.30) + 30),'.00')

--WHEN PRODUCT ON OFFER AND OFFER PRICE BELOW OR EQUAL 399 AND OFFER PRICE LOVER THAN RRP PRICE --> TAKES PRODUCT RRP, ROUNDS IT DOWN, ADDS SHIPPING COST AND .00 AT THE END
WHEN prod_child.onoffer = 1 AND prod_child.offerprice <= 399 AND prod_child.offerprice < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 60,'.00')
--WHEN PRODUCT ON OFFER AND OFFER PRICE OVER 399 AND OFFER PRICE LOVER THAN RRP PRICE --> TAKES PRODUCT RRP, ROUNDS IT DOWN, ADDS .00 AT THE END
WHEN prod_child.onoffer = 1 AND prod_child.offerprice > 399 AND prod_child.offerprice < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 30,'.00')

--WHEN PRODUCT ON OFFER AND OFFER PRICE BELOW OR EQUAL 399 AND OFFER PRICE EQUAL OR HIGHER THAN RRP PRICE --> TAKES PRODUCT OFFER PRICE, ROUNDS IT DOWN, ADDS 30%, ADDS SHIPPING COST AND .00 AT THE END
WHEN prod_child.onoffer = 1 AND prod_child.offerprice <= 399 AND prod_child.offerprice >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.offerprice + (prod_child.offerprice * 0.30)) + 60,'.00')
--WHEN PRODUCT ON OFFER AND OFFER PRICE OVER 399 AND OFFER PRICE EQUAL OR HIGHER THAN RRP PRICE --> TAKES PRODUCT OFFER PRICE, ROUNDS IT DOWN, ADDS 30% AND .00 AT THE END
WHEN prod_child.onoffer = 1 AND prod_child.offerprice > 399 AND prod_child.offerprice >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.offerprice + (prod_child.offerprice * 0.30) + 30),'.00')

--WHEN PRODUCT NOT ON SALE AND NOT ON OFFER AND ORIGINAL PRICE BELOW OR EQUAL 399 AND ORIGINAL PRICE LOVER THAN RRP PRICE --> TAKES PRODUCT RRP, ROUNDS IT DOWN, ADDS SHIPPING COST AND .00 AT THE END
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price <= 399 AND prod_child.price < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp) + 60,'.00')
--WHEN PRODUCT NOT ON SALE AND NOT ON OFFER AND ORIGINAL PRICE OVER 399 AND ORIGINAL PRICE LOVER THAN RRP PRICE --> TAKES PRODUCT RRP, ROUNDS IT DOWN, ADDS .00 AT THE END
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price > 399 AND prod_child.price < prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.rrp + 30),'.00')

--WHEN PRODUCT NOT ON SALE AND NOT ON OFFER AND ORIGINAL PRICE BELOW OR EQUAL 399 AND ORIGINAL PRICE EQUAL OR HIGHER THAN RRP PRICE --> TAKES PRODUCT ORIGINAL PRICE, ROUNDS IT DOWN, ADDS 30%, ADDS SHIPPING COST AND .00 AT THE END
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price <= 399 AND prod_child.price >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.price + (prod_child.price * 0.3)) + 60,'.00')
--WHEN PRODUCT NOT ON SALE AND NOT ON OFFER AND ORIGINAL PRICE OVER 399 AND ORIGINAL PRICE EQUAL OR HIGHER THAN RRP PRICE --> TAKES PRODUCT ORIGINAL PRICE, ROUNDS IT DOWN, ADDS 30% AND .00 AT THE END
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price > 399 AND prod_child.price >= prod_child.rrp AND VAN_KEY IN(2, 5) THEN CONCAT(FLOOR(prod_child.price + (prod_child.price * 0.3) + 30),'.00')

-- VAN_KEY = 1:
-- Sale parecelforce
WHEN prod_child.onsale = 1 AND prod_child.saleprice < prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.rrp) + 10,'.00')
WHEN prod_child.onsale = 1 AND prod_child.saleprice >= prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.saleprice + (prod_child.saleprice * 0.30) + 10),'.00')
-- Offer parcelforce
WHEN prod_child.onoffer = 1 AND prod_child.offerprice < prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.rrp) + 10,'.00')
WHEN prod_child.onoffer = 1 AND prod_child.offerprice >= prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.offerprice + (prod_child.offerprice * 0.30) + 10),'.00')
-- Not on sale and not on offer parcelforce
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price < prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.rrp) + 10,'.00')
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price >= prod_child.rrp AND VAN_KEY = 1 THEN CONCAT(FLOOR(prod_child.price + (prod_child.price * 0.3) + 10),'.00')
--IF NONE OF THE ABOVE --> ORIGINAL PRICE PLUS 30% PLUS SHIPPING COST AND .00 AT THE END
ELSE CONCAT(FLOOR(prod_child.price + (prod_child.price * 0.3)) + VAN_KEY.PRICE,'.00')
END AS [RRP Price],

------------------------------------------------------------------------------------------------------------------

-- PRODUCT DESCRIPTION MADE FROM ITEM SPECIFICS
CONCAT(
'<p style="font-size:16px;text-align:justify">This ',ebay.Room, ' wall mounted ', ebay.[Range name],' ', ebay.Type, ' comes in a ', ebay.Material, ' ', (CASE WHEN prod_child.[modern traditional] = 'M' THEN 'modern' ELSE 'traditional' END),
' design making it a perfect and relevant replacement or addition to any bathroom, cloakroom, loft or en-suite. It is manufactured by ', ebay.Brand, ' and comes with a ', ebay.Guarantee,' guarantee.</p>',
'|<tr><td><strong>BRAND:</strong></td>',
'<td>',UPPER(ebay.Brand),'</td></tr>',
'<tr><td><strong>NAME:&nbsp;&nbsp;</strong></td>',
'<td>',ebay.[Range name],'</td></tr>',
'<tr><td><strong>GUARANTEE:<strong></td>',
'<td>',UPPER(ebay.Guarantee),'</td></tr>',
'|<tr><td style="text-decoration: line-through;color:red"><strong>RRP:</strong> &pound;',
-- RRP (FROM ABOVE), BUY IT NOW PRICE (FROM ABOVE) AND SAVING PRICE (RRP MINUS BUY IT NOW) IN THE DESCRIPTION FOOTER
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

-- If VAN_KEY = 1 then set delivery price as 10 in description
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

-- If VAN_KEY = 1 then set delivery price as 10 in description
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

-- If VAN_KEY = 1 then set delivery price as 10 in description
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

-- If VAN_KEY = 1 then set delivery price as 10 in description
WHEN prod_child.onsale = 1 AND VAN_KEY = 1 THEN FLOOR(prod_child.saleprice) + 10 - 0.06
WHEN prod_child.onoffer = 1 AND VAN_KEY = 1 THEN FLOOR((prod_child.offerprice) + 10)- 0.06
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND VAN_KEY = 1 THEN FLOOR((prod_child.price) + 10)- 0.06

ELSE FLOOR(prod_child.price) - 0.06
END,'</td></tr></table>') AS Description,
 
------------------------------------------------------------------------------------------------------------------
 
-- DESCRIPTION SUMMARY
'THE UKs LARGEST FACTORY OUTLET. Bathroom City has been a leading UK Manufacturer since 1986. With our Birmingham Showroom, Online Stores, Factory and Warehouse, combined with an extensive range of Branded furniture, products and accessories, enables us to turn your dreams into an affordable reality.' AS [Description summary],

------------------------------------------------------------------------------------------------------------------

-- BC EBAY STORE CATEGORY NAMES

ebay.[Store Category] AS [Store Category],
ebay.[Store Category 2] AS [Store Category 2],

-- EBAY CATEGORY IDS

ebay.[eBay Category Id] AS [eBay Category Id],
ebay.[eBay Category2 Id] AS [eBay Category2 Id],

-- CONCAT URL TO IMAGE NAME

CASE WHEN ebay.Image1 !='' AND ebay.Image1 !='NULL' THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image1) ELSE '' END AS Image1,
CASE WHEN ebay.Image2 !='' AND ebay.Image2 !='NULL' THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image2) ELSE '' END AS Image2,
CASE WHEN ebay.Image3 !='' AND ebay.Image3 !='NULL' THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image3) ELSE '' END AS Image3,
CASE WHEN ebay.Image4 !='' AND ebay.Image4 !='NULL' THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image4) ELSE '' END AS Image4,
CASE WHEN ebay.Image5 !='' AND ebay.Image5 !='NULL' THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image5) ELSE '' END AS Image5,
CASE WHEN ebay.Image6 !='' AND ebay.Image6 !='NULL' THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image6) ELSE '' END AS Image6,
CASE WHEN ebay.Image7 !='' AND ebay.Image7 !='NULL' THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image7) ELSE '' END AS Image7,
CASE WHEN ebay.Image8 !='' AND ebay.Image8 !='NULL' THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image8) ELSE '' END AS Image8,
CASE WHEN ebay.Image9 !='' AND ebay.Image9 !='NULL' THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image9) ELSE '' END AS Image9,
CASE WHEN ebay.Image10 !='' AND ebay.Image10 !='NULL' THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image10) ELSE '' END AS Image10,
CASE WHEN ebay.Image11 !='' AND ebay.Image11 !='NULL' THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.Image11) ELSE '' END AS Image11,
CASE WHEN ebay.eDrawing !='' AND ebay.eDrawing !='NULL' THEN CONCAT('https://www.bathroomcity.co.uk/sites/default/files/external/',ebay.eDrawing) ELSE '' END AS Image12,

-- EAN STORED IN eBAY TABLE
'EAN' AS [Ref Type],
ebay.EAN AS [Ref Id],

CASE 
WHEN prod_parent.displayproduct = 0 THEN '0'
WHEN prod_child.displayproduct = 0 THEN '0'
-- IF PRICE IS 0 THEN SET QTY AS 0
WHEN prod_child.onsale = 1 AND prod_child.saleprice = 0 THEN '0'
WHEN prod_child.onoffer = 1 AND prod_child.offerprice = 0 THEN '0'
WHEN prod_child.onoffer = 0 AND prod_child.onsale = 0 AND prod_child.price = 0 THEN '0'
ELSE '1' 
END AS QTY,
-- Checks VAN_KEY and assigns delivery service name based off the key.
CASE 
WHEN VAN_KEY.VAN_KEY = 5 THEN 'UK_OtherCourier'
WHEN VAN_KEY.VAN_KEY = 2 THEN 'UK_OtherCourier' 
WHEN VAN_KEY.VAN_KEY = 1 THEN 'UK_Parcelforce48'
ELSE ebay.[Delivery Service 1 Name] END AS [Delivery Service 1 Name],
0 AS [Delivery Service 1 Price],
0 AS [Delivery Service 1 Add Price],

-- Checks VAN_KEY for which shipping method to use and the price of it.
CASE 
WHEN VAN_KEY.VAN_KEY = 5 THEN 'UK_OtherCourier24'
WHEN VAN_KEY.VAN_KEY = 2 THEN 'UK_OtherCourier24'
WHEN VAN_KEY.VAN_KEY = 1 THEN 'UK_ParcelForce24' END AS [Delivery Service 2 Name],
10 AS [Delivery Service 2 Price] ,
10 AS [Delivery Service 2 Add Price],
'UK_CollectInPerson' AS [Delivery Service 3 Name],
0 AS [Delivery Service 3 Price],
-- DELIVERY OPTIONS, DELIVERY SERVICE 1 PRICE COLUMN FROM EBAY TABLE IS ADDED TO ITEM PRICE AND DISPLAYED AS FREE SHIPPING ON EBAY 
/*
ebay.[Delivery Service 1 Name] AS [Delivery Service 1 Name], 

CASE 
WHEN prod_child.onsale = 1 AND prod_child.saleprice <= 399 THEN '0'
WHEN prod_child.onsale = 1 AND prod_child.saleprice > 399 THEN 

WHEN prod_child.onoffer = 1 AND prod_child.offerprice <= 399 THEN 
WHEN prod_child.onoffer = 1 AND prod_child.offerprice > 399 THEN 

WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price <= 399 THEN 
WHEN prod_child.onsale = 0 AND prod_child.onoffer = 0 AND prod_child.price > 399 THEN 

ELSE
END AS [Delivery Service 1 Price],

[Delivery Service 1 Add Price] AS [Delivery Service 1 Add Price],

ebay.[Delivery Service 1 Name] AS [Delivery Service 1 Name],
'0' AS [Delivery Service 1 Price],
[Delivery Service 1 Add Price] AS [Delivery Service 1 Add Price],


ebay.[Delivery Service 2 Name] AS [Delivery Service 2 Name],
ebay.[Delivery Service 2 Price] AS [Delivery Service 2 Price],
ebay.[Delivery Service 2 Add Price] AS [Delivery Service 2 Add Price],

'UK_CollectInPerson' AS [Delivery Service 3 Name],
'0' AS [Delivery Service 3 Price],
*/
'Yes' AS [Apply Domestic Rate Table],
'No' AS [Apply International Rate Table],
'CF,ZA' AS [Exclude Postage Locations],
'Disabled' AS [Best Offer Enabled],
'GB' AS [Ship Also],

-- EBAY ITEM SPECIFICS
'Brand' AS [Item Specifics 1 Name],
CASE
WHEN ebay.Brand != '' THEN ebay.Brand
ELSE UPPER(supplier2) END AS [Item Specifics 1 Value],

'Name' AS [Item Specifics 2 Name],
CASE WHEN ebay.[Range name] != '' THEN ebay.[Range name] ELSE UPPER(prod_parent.range_name) END AS [Item Specifics 2 Value],

'MPN' AS [Item Specifics 3 Name],
ebay.SKU AS [Item Specifics 3 Value],

'Main Colour' AS [Item Specifics 4 Name],
ebay.[Main colour] AS [Item Specifics 4 Value],

'Colour' AS [Item Specifics 5 Name],
ebay.Colour AS [Item Specifics 5 Value],

'Tap Hole' AS [Item Specifics 6 Name],
ebay.[Tap Hole] AS [Item Specifics 6 Value],

--'Shape' AS [Item Specifics 7 Name],
--ebay.Shape AS [Item Specifics 7 Value],

'Sink Type' AS [Item Specifics 8 Name],
ebay.[Sink Type] AS [Item Specifics 8 Value],

--ITEM DIMENTIONS TAKEN FROM CHILD TABLE, IF NOT FOUND IN THE CHILD TABLE, 'N/A' IS DISPLAYED ON EBAY
'Length (cm)' AS [Item Specifics 9 Name],
CASE
WHEN prod_child.width = '0'
THEN CAST('N/A' AS Varchar(20))
ELSE CAST(prod_child.width/10 AS Varchar(20))
END AS [Item Specifics 9 Value],

'Width (cm)' AS [Item Specifics 10 Name],
CASE
WHEN prod_child.width = '0'
THEN CAST('N/A' AS Varchar(20))
ELSE CAST(prod_child.width/10 AS Varchar(20))
END AS [Item Specifics 10 Value],

'Height (cm)' AS [Item Specifics 11 Name],
CASE
WHEN prod_child.height = '0'
THEN CAST('N/A' AS Varchar(20))
ELSE CAST(prod_child.height/10 AS Varchar(20))
END AS [Item Specifics 11 Value],

'Depth (cm)' AS [Item Specifics 12 Name],
CASE
WHEN prod_child.depth = '0'
THEN CAST('N/A' AS Varchar(20))
ELSE CAST(prod_child.depth/10 AS Varchar(20))
END AS [Item Specifics 12 Value],

'Design' AS [Item Specifics 13 Name],
CASE
WHEN prod_child.[modern traditional] = 'M'
THEN 'Modern'
WHEN prod_child.[modern traditional] = 'T'
THEN 'Traditional'
ELSE 'Modern'
END AS [Item Specifics 13 Value],

'Material' AS [Item Specifics 14 Name],
ebay.Material AS [Item Specifics 14 Value],

'Type' AS [Item Specifics 15 Name],
ebay.Type AS [Item Specifics 15 Value],

'Guarantee' AS [Item Specifics 16 Name],
ebay.Guarantee AS [Item Specifics 16 Value],
'Included' AS [Item Specifics 17 Name],
ebay.Included AS [Item Specifics 17 Value],
'Excluded' AS [Item Specifics 18 Name],
ebay.Excluded AS [Item Specifics 18 Value],
'Fitting' AS [Item Specifics 19 Name],
ebay.Fitting AS [Item Specifics 19 Value],
'Overflow' AS [Item Specifics 20 Name],
ebay.Overflow AS [Item Specifics 20 Value],
'Country/Region of Manufacture' AS [Item Specifics 21 Name],
ebay.ManufacturedIn AS [Item Specifics 21 Value],
'Room' AS [Item Specifics 22 Name],
ebay.Room AS [Item Specifics 22 Value],
'Bundle listing' AS [Item Specifics 23 Name],
ebay.[Bundle listing] AS [Item Specifics 23 Value],
'Features' AS [Item Specifics 24 Name],
ebay.Features AS [Item Specifics 24 Value],

CONCAT(ebay.SimilarProduct1,', ',ebay.SimilarProduct2,', ',ebay.SimilarProduct3,', ',ebay.SimilarProduct4) AS [Similar products],
ebay.[AdLister TAGS] AS Tag,
ebay.eStatus


from prod_parent
JOIN categories c1 ON prod_parent.prod_parent_new_cat = c1.CatID
INNER JOIN categories c2 ON c1.ParentID = c2.CatID
FULL JOIN prod_child ON prod_parent.parentid = prod_child.child_parentid
FULL JOIN [intranet-test].[dbo].[ebayTable] ebay ON prod_child.childid = ebay.eChildID
join VAN_KEY on VAN_KEY.VAN_KEY = prod_parent.van
WHERE ebay.tag = 'Towel Rail'
ORDER BY SKU