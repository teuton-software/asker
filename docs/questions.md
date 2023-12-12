[<< back](../README.md)

# Question list

## Concept questions

Questions based on the content of `tables`.

| ID                            | type    |
| ----------------------------- | ------- |
| b1match4x4                    | match   |
| b1ddmatch4x4                  | ddmatch |
| b1match4x5                    | match   |
| b1match4x5_1misspelled        | match   |
| b1match4x4_1misspelled        | match   |
| b1ddmatch4x4_1misspelled      | ddmatch |
| b1match4x5_1misspelled_1error | match   |
| b1match4x5_2misspelled        | match   |
| b1match4x4_1error             | match   |
| b1ddmatch4x4_1error           | ddmatch |
| b1match4x5_1error_1misspelled | match   |

Questions based on text `def` fields.

| ID                 | type    |
| ------------------ | ------- |
| d1choose           | choice  |
| d1none-misspelled  | choice  |
| d1none             | choice  |
| d2def-misspelled   | choice  |
| d2name-misspelled  | choice  |
| d2true-misspelled  | boolean |
| d2true             | boolean |
| d2false-misspelled | boolean |
| d2false            | boolean |
| d3hidden           | Short answer |
| d4filtered         | match  |

Associate a group of columns from a table.

| ID                | Type    |
| ----------------- | ------- |
| f1true            | boolean |
| f1short           | short answer |
| f1name-misspelled | choice  |
| f1true-misspelled | choice  |
| f1false           | boolean |
| f2outsider        | choice  |
| f3filtered        | match   |

Questions based on images `def` fields.

| ID            | type   |
| ------------- | ------ |
| i1choice      | choice |
| i1misspelling | choice |
| i1none        | choice |
| i2true        | boolean |
| i2false       | boolean |
| i3short       | short answer |
| i4filtered    | match |

Questions based on the content of `tables` with `sequence`.

| ID         | type  |
| ---------- | ----- |
| s1sequence | match |
| s2sequence | match |

Associate individual columns from a table.

| ID      | type |
| ------- | ------- |
| t1table | choice  |
| t2table | choice  |
| t3table | choice  |
| t4table | choice  |
| t5table | boolean |
| t6table | boolean |
| t7table | boolean |
| t8table | short answer |
| t9table | short answer |

## Code questions

Questions based on `code` files:

| ID               | type   |
| ---------------- | ------ |
| code1uncomment   | choice |
| code1comment     | choice |
| code1ok          | choice |
| code1syntaxerror | choice |
| code1variable    | choice |
| code1keyword     | choice |

## Problem questions

Questions based on the `answer` field:

| ID                | type         |
| ----------------- | ------------ |
| 01pa1true         | Boolean      |
| 02pa1false        | Boolean      |
| 03pa2-choice-none | Choice       |
| 04pa2choice       | Choice       |
| 05pa2choice       | Choice       |
| 06pa2short        | Short answer |

Questions based on the `steps` field:

| ID                | type         |
| ----------------- | ------------ |
| 07ps3short-ok     | Short answer |
| 08ps6ordering     | Ordering     |
| 09ps7short-hide   | Short answer |
| 10ps3short-error  | Short answer |
| 11ps5match        | Match        |
| 12ps5ddmatch      | DDMatch      |
