# MongoDB Hands-on Practice — Student Version

**Course:** CSCI 480 / CIS 680 Advanced Databases  
**Estimated time:** 60–75 minutes  
**Goal:** Connect document databases in the NoSQL lecture with MongoDB operations.

## Part A — Start and inspect (10 minutes)

1. Run `bash scripts/reset-data.sh` from the Codespaces terminal.
2. Run `docker compose exec mongo mongosh campus_store`.
3. Run `show collections`, `db.customers.countDocuments({})`, and `db.orders.countDocuments({})`. Record the counts.
4. Display one customer and one order. Identify a nested object, an array, and the `_id` field.

## Part B — Query documents with `find()` (20 minutes)

Write and execute a query for each question. Record your query and result.

1. Find all customers in Kenosha.
2. Show only customer names and cities, excluding `_id`.
3. Find orders with `total` greater than 40.
4. Find orders that are `pending` or `cancelled`.
5. Find customers interested in `books`.
6. Find customers whose `address.zip` equals `53142`.
7. Sort orders by `total` descending, returning only the top three.
8. Find orders containing an item with `sku` equal to `E01`.

## Part C — CRUD (15 minutes)

1. Insert a fictional customer with `_id: 106`, name, city, and interests.
2. Change customer 106's city using `updateOne()` and `$set`.
3. Add `"databases"` to customer 106's interests using `$addToSet`.
4. Delete customer 106 with `deleteOne()`.
5. Verify that customer 106 no longer exists.

## Part D — Documents and relationships (10 minutes)

1. Explain why `orders.items` is an example of **embedding**.
2. Explain why `orders.customerId` is an example of a **reference**.
3. Find all orders placed by customer 101.
4. In two or three sentences, compare this model with a relational `Customers` and `Orders` schema.

## Part E — Import data (10 minutes)

Leave `mongosh` with `exit`, then run the following **Linux terminal** command:

```bash
docker compose exec -T mongo mongoimport --db campus_store --collection imported_customers --file /dev/stdin --jsonArray < data/customers.json
```

Return to `mongosh` and verify that `imported_customers` contains five documents. Why does the import command use `--jsonArray`?

## Optional challenge — Aggregation (10 minutes)

Use `$group` to calculate the total order value by status. Sort results from highest to lowest total.

## Submission

Submit a short document containing your queries and outputs for Parts B and C and written responses for Part D. No screenshots required. Do not submit the instructor solution file.
