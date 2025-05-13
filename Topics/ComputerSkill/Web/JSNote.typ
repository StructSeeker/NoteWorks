=== yield and generator
the first input `gen(x).next(firstInput)` will be ignored, and the first output will be the first `yield` statement.

=== createElement
```javascript
const createElement = (doc, tag, attrs) => {
		const el = doc.createElement(tag);
    Object.entries(attrs).forEach(([key, value]) => {
      key === "text" ? el.textContent = value : el.setAttribute(key, value);
    })
		return el;
};
```


