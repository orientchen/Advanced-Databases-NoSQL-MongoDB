# Instructor Solutions — Do Not Distribute With Student Repository

## A

`customers`: 5; `orders`: 6. Example nested object: `address`; array: `interests` or `items`; identifier: `_id`.

## B

```javascript
db.customers.find({city:"Kenosha"});
db.customers.find({}, {_id:0, name:1, city:1});
db.orders.find({total:{$gt:40}});
db.orders.find({status:{$in:["pending","cancelled"]}});
db.customers.find({interests:"books"});
db.customers.find({"address.zip":"53142"});
db.orders.find().sort({total:-1}).limit(3);
db.orders.find({"items.sku":"E01"});
```

Expected: Kenosha customers 101 and 103; totals >40 are orders 5001 and 5003; pending/cancelled 5002, 5004, 5006; books 101 and 103; ZIP 53142 customer 103; top totals 89, 65, 40; SKU E01 orders 5001 and 5005.

## C

```javascript
db.customers.insertOne({_id:106,name:"Practice Student",city:"Kenosha",interests:["books"]});
db.customers.updateOne({_id:106},{$set:{city:"Racine"}});
db.customers.updateOne({_id:106},{$addToSet:{interests:"databases"}});
db.customers.deleteOne({_id:106});
db.customers.find({_id:106});
```

## D

`items` embeds line-item subdocuments in each order. `customerId` references a separate customer document; it is not an enforced foreign key. Query: `db.orders.find({customerId:101});` → orders 5001 and 5004. A relational design would typically use a foreign key from Orders to Customers and a separate OrderItems table; embedding can retrieve an order with its items in one document.

## E

```javascript
db.imported_customers.countDocuments({}); // 5
```

`--jsonArray` indicates the input file is one JSON array of documents rather than newline-delimited JSON documents. Repeating the import may produce duplicate `_id` errors; drop the imported collection before reimporting.

## Optional challenge

```javascript
db.orders.aggregate([
  {$group:{_id:"$status",sumTotal:{$sum:"$total"}}},
  {$sort:{sumTotal:-1}}
]);
```

Expected shipped = 190; cancelled = 40; pending = 60. Sorted: shipped 190, pending 60, cancelled 40.
