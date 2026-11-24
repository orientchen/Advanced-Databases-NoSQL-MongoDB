# MapReduce: A Worked Example

This example illustrates Figure 14.5: how MapReduce calculates the **total number of units sold for each product** using invoice data distributed across multiple DataNodes.

## 1. Map Phase

Each mapper processes an input block and generates key-value pairs:

- **Key:** Product code (`p_code`)
- **Value:** Quantity sold (`line_units`)

The three mappers can operate in parallel.

| DataNode 1 (Block 1) | DataNode 2 (Block 3) | DataNode 4 (Block 2) |
| --- | --- | --- |
| `(13-Q2/P2, 1)` | `(2238/QPD, 1)` | `(54778-2T, 3)` |
| `(23109-HB, 1)` | `(1546-QQ2, 1)` | `(23109-HB, 2)` |
| `(54778-2T, 2)` | `(13-Q2/P2, 5)` | |

## 2. Shuffle and Sort Phase

Although not explicitly shown in the textbook figure, the shuffle and sort phase groups intermediate values associated with the same key.

| Key (product code) | Grouped values |
| --- | --- |
| `13-Q2/P2` | `[1, 5]` |
| `23109-HB` | `[1, 2]` |
| `54778-2T` | `[2, 3]` |
| `2238/QPD` | `[1]` |
| `1546-QQ2` | `[1]` |

## 3. Reduce Phase

The reducer calculates the sum of the values associated with each key.

| Product code | Calculation | Total units sold |
| --- | --- | ---: |
| `13-Q2/P2` | 1 + 5 | **6** |
| `23109-HB` | 1 + 2 | **3** |
| `54778-2T` | 2 + 3 | **5** |
| `2238/QPD` | 1 | **1** |
| `1546-QQ2` | 1 | **1** |

## 4. Equivalent SQL Operation

If the invoice line items were stored in a relational table, the equivalent SQL operation would be:

```sql
SELECT p_code, SUM(line_units)
FROM LINE
GROUP BY p_code;
```

Both approaches perform grouping and aggregation. MapReduce provides a framework for distributing this computation across multiple machines; distributed SQL engines can also perform this operation in parallel.

## 5. Why Is DataNode 3 Not Used?

HDFS stores multiple replicas of each block. MapReduce processes each logical input block only once, rather than treating all its replicas as separate input. Otherwise, the quantities would be counted multiple times.

In this example, the system uses:

- Block 1 from DataNode 1
- Block 3 from DataNode 2
- Block 2 from DataNode 4

DataNode 3 is not needed for this particular illustrated assignment of input blocks.

## 6. Summary

**Map → Shuffle and Sort → Reduce**

| Phase | Responsibility |
| --- | --- |
| Map | Generate key-value pairs. |
| Shuffle and Sort | Group values associated with the same key. |
| Reduce | Aggregate values for each key. |

For example, the product `13-Q2/P2` follows this sequence:

```text
Map                 Shuffle and Sort        Reduce
(13-Q2/P2, 1)  ─┐
                ├──> (13-Q2/P2, [1, 5]) ──> (13-Q2/P2, 6)
(13-Q2/P2, 5)  ─┘
```
