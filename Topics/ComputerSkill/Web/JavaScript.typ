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

=== A lambda that rembember this
```js
const obj = Reflect.apply(
  function () {
    this.x = 3;
    this.fn = () => this.x;
    return this;
  },
  Object(),
  []
);
```

=== Scroll to tag with certain events.
```js
Array.from(document.querySelectorAll("span") ).
  map(x => [x, getEventListeners(x)]).
  filter(obj => 'click' in obj[1])[0][0].scrollIntoView()
```


=== Destructure Argument in function 
```js
const fn = ([_x, y]) => y;
const fn = ({_x, y = 3}) => y;

```


== Create a list of scripts
```js
		[
			['https://hypothes.is/embed.js', true],
			// ['document.body.style.position = "static";', false],
		].forEach(function (arg) {
			let [src, urlQ] = arg;
			var script = document.createElement('script');
			script[(urlQ ? "src" : "text")] = src;
			script.async = false
			document.head.appendChild(script);
		});
```