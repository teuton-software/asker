
[<< back](README.md)

# Learn tables

Now, we are going to learn thas last keywords:
* table, row and col

Let's go.

---

# Def limits

We have learn that:
* **map** serves to identify an input file.
* **concept**, **names** and **tags** serves to identify a concept.
* **def** serves to add meaning to a concept.

But, it's not enough. **def** only contains meaning that could only be associated to one unique concept. For example:
```
  %concept
    %names AC/DC, ACDC
    %tags rock, band, australia
    %def Australian rock band formed by Scottish-born brothers Malcolm and Angus Young
```

**def** is good but we need other keyword to add meaning that isn't uniquely associated to one concept. That is **table** keyword.

# Tables

## 1 field

Example, adding meaning using 1 field table. Field called `members`:

```
%concept
  %names AC/DC, ACDC
  %tags single, seat, leg, backrest
  %tags rock, band, australia
  %table{ :fields => 'members'}
    %row Bon Scott
    %row Angus Young
    %row Malcolm Young
    %row Phil Rudd
    %row Cliff Williams
```

| Param  | Description |
| ------ | ----------- |
| fields | Comma separated values with field name |
| row    | Field value |

## 2 fields

Example, adding meaning using 2 fields table. Fields called `attribute` and `value`:

```
  %concept
    %names AC/DC, ACDC
    %tags single, seat, leg, backrest
    %tags rock, band, australia
    %table{ :fields => 'attribute, value'}
      %row
        %col Genres
        %col Hard rock blues rock rock and roll
      %row
        %col Years active
        %col 1973–present
      %row
        %col Origin
        %col Sydney
      %row
        %col Formed in
        %col 1973
```

| Param  | Description |
| ------ | ----------- |
| fields | Comma separated values with field names |
| row    |             |
| col    | Field column value |

## Sequence

Albums High Voltage, in 1975.
in 1977 for the album Powerage.
In February 1980, bringing in Brian Johnson.
Back in Black 1980
