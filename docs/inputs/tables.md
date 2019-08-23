
[<< back](README.md)

# Learn tables

Now, we are going to learn thas last keywords:
* table, row and col

Let's go.

---

# Def limitation

We have learn that:
* **map** serves to identify an input file.
* **concept**, **names** and **tags** serves to identify a concept.
* **def** serves to add meaning to a concept.

But, it's not enough. **def** only contains meaning that could only be associated to one unique concept. For example:
```
  %concept
    %names chair
    %tags single, seat, leg, backrest
    %def Single seat with legs and backrest
```

**def** is good but we need other keyword to add meaning that isn't uniquely associated to one concept. That is **table** keyword.

# Tables

Example, adding meaning to `chair` concept using 1 field table. Field called `features`:

```
%concept
  %names chair
  %tags single, seat, leg, backrest
  %def Single seat with legs and backrest
  %table{ :fields => 'features'}
    %row Sigle person seat
    %row Has legs
    %row Has backrest
    %row May have armrest or not
```

Example, adding meaning using 2 fields table. Fields called `attribute` and `value`:

```
%concept
  %names chair
  %tags single, seat, leg, backrest
  %def Single seat with legs and backrest
  %table{ :fields => 'attribute,value'}
    %row
      %col Sigle person seat
    %row Has legs
    %row Has backrest
    %row May have armrest or not
```
