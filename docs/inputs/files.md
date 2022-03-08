
[<< back](README.md)

# Including external files

The`def` tag is used to put text that define our concept.
By default `def` type is text, but it's posible define our concepts with external files.

Let's see how.

# Loading files example

Suppose we have this file organization:

```
loading_files
├── images
│   └── john-lennon.png
├── txt
│   └── quote.txt
└── john-lennon.haml
```

Take a look to our loading files example (`docs/examples/loading_files/john-lennon.haml`):

```
%concept
  %names John Lennon
  %tags famous, singer, player, member, beatles
  %def{ type: 'file'} txt/quote.txt
  %def{ type: 'file'} images/john-lennon.png
  %def{ type: 'file'} https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/John_Lennon_1969_%28cropped%29-Colorized.jpg/800px-John_Lennon_1969_%28cropped%29-Colorized.jpg
```

This example use external files to define the concept:
* First definition use external local text file.
* Second definition use external local image file.
* And the third use external remote image file.

# Conclusion

**def** can be used with local or remote images. So we have to find an image that uniquely identifies our concept and write our definitions like this.

```
    %def{:type => 'file'}PATH-TO-FILE
```

| Attribute | Value | Description  |
| --------- | ----- | ------------ |
| type      | file  | Value is an URL or PATH to file |

**WARNING**: By now only PNG, JPG, JPEG and TXT type files are accepted.

---
[>> Learn about tables](tables.md)
